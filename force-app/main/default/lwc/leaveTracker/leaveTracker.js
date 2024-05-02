import { LightningElement,api} from 'lwc';

export default class LeaveTracker extends LightningElement {

    @api recordId;

    refreshLeaveReqeuestHandler(event) {
        this.refs.myLeavesComp.refreshGrid();
    }
}