import { LightningElement } from 'lwc';

export default class LWC_events extends LightningElement { 

    inchandler(event){
        const inc= new CustomEvent('increase');
        this.dispatchEvent(inc);
    }
    dechandler(event){
        this.dispatchEvent(new CustomEvent('decrease'));
    }
}