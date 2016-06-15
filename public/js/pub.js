function clearczjDefaultText(el, czjmessage) {
    var obj = el;
    if (typeof(el) == "string")
        obj = document.getElementByIdx_x(id);
    if (obj.value == czjmessage) {
        obj.value = "";
    }
    obj.onblur = function () {
        if (obj.value == "") {
            obj.value = czjmessage;
        }
    }
}



