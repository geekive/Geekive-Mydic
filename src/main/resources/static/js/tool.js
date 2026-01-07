function isEmpty(value){
	value = $.trim(value);
	return value === undefined || value === null || value === '';
}

function isNotEmpty(value) {
    value = $.trim(value);
    return value !== undefined && value !== null && value !== '';
}

function isEmailFormat(value){
	const emailRegex 	= /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	value 				= $.trim(value);
	return emailRegex.test(value);
}

function isPasswordFormat(value){
	const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>_-]).+$/;
	return passwordRegex.test(value);
}

function getFullPath(path){
	const host 			= window.location.origin;
	const url			= host + path.replace(/\s+/g, '');
	return url;
}

function goToPage(path, option){
	const url = getFullPath(path);
	if(isEmpty(option)){
		option = 'href';
	}
	if(option === 'href'){
		window.location.href = url;
	}else if(option === 'replace'){
		window.location.replace(url);
	}else if(option === '_blank'){
		window.open(url);
	}
}

function fnShowObject($object){
	$object.removeClass('hide').show();
}

function fnHideObject($object){
	$object.hide();
}

function getErrorImageUrl(image, type){
	$.ajax({
        type		: 'post',
        url			: getFullPath('/errorImage'),
        contentType	: 'application/json',
        data		: JSON.stringify({type : type}),
        success: function(data){
            image.src = data;
        }
    });
}

function setCookie(key, value, path, maxAge){
	document.cookie = '' + key + '=' + value + '; path=' + path + '; max-age=' + maxAge + '';
}

function fnEscapeHtml(value){
  return String(value)
    .replaceAll("&","&amp;")
    .replaceAll("<","&lt;")
    .replaceAll(">","&gt;")
    .replaceAll('"',"&quot;")
    .replaceAll("'","&#039;");
}
