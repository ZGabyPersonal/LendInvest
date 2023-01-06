/**
 * Created by GabyZamfir on 04/01/2023.
 */

import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import sendSMS from '@salesforce/apex/TwilioService.sendSMS';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


import PHONE_FIELD from '@salesforce/schema/Account.Phone'
const fields = [PHONE_FIELD];

export default class SendCustomSms extends LightningElement {
    @api recordId;
    message = '';
    @api isLoading = false;
    @wire(getRecord, { recordId: '$recordId', fields })
    account;

    handleInputChange(event) {
        this.message = event.target.value;
    }

    handleSendSms() {
        this.isLoading = true;

        console.log('message', this.message);
        sendSMS({ message: this.message, toNumber: this.account.data.fields['Phone'].value })
            .then(result => {
                const toastEvt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Message Sent!',
                    variant: 'success'
                });
                this.dispatchEvent(toastEvt);
                this.message = '';
            })
            .catch(error => {
                const toastEvt = new ShowToastEvent({
                    title: 'Error',
                    message: error?.body?.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvt);
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}