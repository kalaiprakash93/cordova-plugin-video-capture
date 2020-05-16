window.video_capture = function(task,args,success,error) {
	cordova.exec(success, error, "videoCapture", task, args);
};
