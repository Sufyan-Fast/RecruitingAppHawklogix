import { LightningElement, wire, track, api } from "lwc";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createRecord from '@salesforce/apex/lwc_Form_Controller.saveJobApplication';


export default class FormPage extends LightningElement {

	name ='';
    email = '';
    phone = '';
    address = '';
    referredBy = '';
    coverLetterText = '';
    Resume = '';

    acceptedFormats = ['.pdf', '.doc', '.docx'];
    recordId;
    coverId;

    handleNameChange(event){
        this.name = event.target.value;
    }
    handleEmailChange(event){
        this.email = event.target.value;

    }
    handlePhoneChange(event){
        this.phone = event.target.value;

    }
    handleAddressChange(event){
        this.address = event.target.value;
 
    }
    handleReferredByChange(event){
        this.referredBy = event.target.value;

    }

    handleUploadFinished(event) {
        // Get the uploaded file's ContentDocumentId
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            this.recordId = uploadedFiles[0].documentId;
        }
    }
    handleUploadCoverFinished(event) {
        // Get the uploaded file's ContentDocumentId
        const uploadedFile = event.detail.files;
        if (uploadedFile.length > 0) {
            this.coverId = uploadedFile[0].documentId;
        }
    }

    handleSubmit(){
        createRecord({applicantName: this.name, Email: this.email, phone: this.phone ,Address: this.address, referredby: this.referredBy, resumeDocumentId: this.recordId,coverDocumentId: this.coverId})
        .then( result =>{
            console.log('Succesfully Added');
        })
        .catch ( error => {
            console.log(error);
        });

    }




	resetForm() {
        const formFields = this.template.querySelectorAll('lightning-input, lightning-textarea');

        formFields.forEach(field => {
            field.value = null; 
        });
    }

}