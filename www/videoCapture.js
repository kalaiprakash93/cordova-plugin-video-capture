window.videocapture = function(task,args,success,error) {
	cordova.exec(success, error, "videoCapture", task, args);
};
