function start() {
    const nativeCommunicator = typeof webkit !== 'undefined' ? webkit.messageHandlers.native : window.native;

    const scripts = document.getElementsByTagName('script');
    let code;
    for (let i = 0; i < scripts.length; i++) {
        console.log(scripts[i].innerText);
        console.log(scripts.length);
        if (scripts[i].innerText.includes("eval(function(p,a,c,k,e,d)") && scripts[i].innerText.includes("MDCore")) {
            code = scripts[i].innerText;
            break;
        }
    }

    if(code == null) {
        nativeCommunicator.postMessage(JSON.stringify({
            "name" : "AQ_ERROR_SUBMIT",
            "data" : "NONE",
        }));
        return;
    }else {
        const startIndex = code.indexOf('eval(function(p,a,c,k,e,d)');

        code = code.substring(startIndex);
        nativeCommunicator.postMessage(JSON.stringify({
            "name" : "AQ_EVAL_SUBMIT",
            "data" : code,
        }));
    }

    return 0;

}

start();