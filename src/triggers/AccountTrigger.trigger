trigger AccountTrigger on Account (after update) {
	new AccountTriggerHandler().run();
}