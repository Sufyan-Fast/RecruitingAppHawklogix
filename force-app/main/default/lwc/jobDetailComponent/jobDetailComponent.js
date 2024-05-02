import { LightningElement,api,wire} from 'lwc';
import Get_JOB_DATA from '@salesforce/apex/LWCSItesController.getJobData';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import jquery from '@salesforce/resourceUrl/jquery';
import bootstrap from '@salesforce/resourceUrl/bootstrap';
import Get_Site_URL from '@salesforce/apex/LWCSItesController.getLWCSitesURL';
export default class JobDetailComponent extends LightningElement {
   // recordId;
    JobData;
    error;
    siteURL;
    dumyData = {
        Name : 'Dummy job',
        formattedPostedDate : 'January 27, 1999',
        applyURL : '#',
        Job_Description__c : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel dui eget lorem accumsan laoreet ac quis risus. Suspendisse fringilla justo id eleifend varius.',
        Job_Requirements__c : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel dui eget lorem accumsan laoreet ac quis risus. Suspendisse fringilla justo id eleifend varius.',
        Qualifications__c : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel dui eget lorem accumsan laoreet ac quis risus. Suspendisse fringilla justo id eleifend varius.',
        cmbAddress : 'test, Record',
        Job_Number__c : 'job-0000',
        Employment_type__c : 'Test Type',
        Salary__c : '00,000/Month',
        Experience_Required__c : '0 Years',
        formattedTargetDate : 'January 27, 1999'

    };

    renderedCallback() {
        Promise.all([
            loadStyle(this, bootstrap + '/bootstrap/css/bootstrap.css'),
            // loadStyle(this, bootstrap + '/bootstrap/css/bootstrap.min.css'),
            loadScript(this, bootstrap + '/bootstrap/js/bootstrap.js'),
            loadScript(this, jquery)     
        ])
            .then(() => {
                console.log('Bootstrap Loaded');
            })
            .catch(error => {
                console.log('Bootstrap Not Loaded');
            });
    }

    async connectedCallback() {
        let params = {};
        params = await this.getQueryParameters();
        console.log('params=>' ,JSON.stringify(params));
        const obj = Object.assign({}, params);
        console.log('obj=>', obj);
        let recordId = obj.id;
        // this.JobData = (recordId ===null ||  recordId === '')? this.dumyData : '';
        if (recordId === undefined || recordId === null)
        {
            console.log('No id fetch');
            this.JobData = this.dumyData;
        }
        else
        {
        console.log('Idrecord=>' ,recordId);
        await this.getSiteURL();
        await this.getJobData(recordId);
        }
    }
    getQueryParameters() {
        let params = {};
        let search = location.search.substring(1);
        if (search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value)
            });
        }
        return params;
    }

    async getSiteURL()
    {
        await Get_Site_URL()
        .then(result=>{
            console.log('urlresult=>' ,  result);
            this.siteURL = result;
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.siteURL = undefined;
        });
    }

    async getJobData(recordId)
    {
        console.log('getjobdatarecordId=>',recordId );
        try {
            const result = await Get_JOB_DATA({
                recordId: recordId,
            });
            console.log('result' , result);
            this.JobData = result;
            console.log('this.JobData' , this.JobData);
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            let site = this.siteURL;
            let jobData = {
                ...this.JobData,
                formattedPostedDate : result.Date_Posted__c? new Date(result.Date_Posted__c).toLocaleDateString('en-US', options):'',
                formattedTargetDate : result.Target_Hire_Date__c? new Date(result.Target_Hire_Date__c).toLocaleDateString('en-US', options):'',
                applyURL : site + 'apply?id=' + result.Id,
                cmbAddress : result.City__c + ', ' + result.Country__c
            };
            this.JobData = jobData;
            console.log('jobdata' , jobData);
            this.error = undefined;
          } catch (error) {
            this.error = error;
            this.JobData = undefined;
          }
    }





}