declare module "@salesforce/apex/LWCSItesController.getJobData" {
  export default function getJobData(param: {recordId: any}): Promise<any>;
}
declare module "@salesforce/apex/LWCSItesController.getAllJobs" {
  export default function getAllJobs(): Promise<any>;
}
declare module "@salesforce/apex/LWCSItesController.getViewAllJobs" {
  export default function getViewAllJobs(): Promise<any>;
}
declare module "@salesforce/apex/LWCSItesController.searchJobs" {
  export default function searchJobs(param: {searchQuery: any}): Promise<any>;
}
declare module "@salesforce/apex/LWCSItesController.saveJobApplication" {
  export default function saveJobApplication(param: {applicantName: any, jobId: any, Email: any, phone: any, Addresses: any, referredby: any, fileContents: any, fileName: any, fileCoverContents: any, filenameCover: any}): Promise<any>;
}
declare module "@salesforce/apex/LWCSItesController.getLWCSitesURL" {
  export default function getLWCSitesURL(): Promise<any>;
}
