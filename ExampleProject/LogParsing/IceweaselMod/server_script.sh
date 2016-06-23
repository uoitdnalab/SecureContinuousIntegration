#This file serves commands to a modified version of Iceweasel to run an XSS test
echo "Server script was started"

echo "Serving first command"
echo -ne "xss_menu=document.getElementById('xssmecontextmenu')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done first command"

echo "Serving second command"
echo -ne "xss_menu.click()" | nc -l -p 9876 -q 0 > /dev/null
echo "Done second command"

echo "Serving third command"
echo -ne "tabs=window.sidebar.document.getElementsByTagName('tab')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done third command"

echo "Serving fourth command"
echo -ne "for(var i=0; i < tabs.length; i++){if(tabs[i].label=='Unnamed form 2') {tabs[i].click();break;} }" | nc -l -p 9876 -q 0 > /dev/null
echo "Done fourth command"

echo "Serving fifth command"
echo -ne "captions=window.sidebar.document.getElementsByTagName('caption')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done fifth command"

echo "Serving sixth command"
echo -ne "for(var i=0; i < captions.length; i++){if (captions[i].label=='comment_text') {mycaption=captions[i];break;}}" | nc -l -p 9876 -q 0 > /dev/null
echo "Done sixth command"

echo "Serving seventh command"
echo -ne "for(var i=0; i < captions.length; i++){if (captions[i].label=='comment_text') { mycaption=captions[i];break;}}" | nc -l -p 9876 -q 0 > /dev/null
echo "Done seventh command"

echo "Serving eights command"
echo -ne "mycaption.parentNode.getElementsByTagName('checkbox')[0].click()" | nc -l -p 9876 -q 0 > /dev/null
echo "Done eights command"

echo "Serving ninth command"
echo -ne "for(var i=0; i < captions.length; i++){if (captions[i].label=='username') { mycaption=captions[i];break;}}" | nc -l -p 9876 -q 0 > /dev/null
echo "Done ninth command"

echo "Serving tenth command"
echo -ne "mymenu=mycaption.parentNode.getElementsByTagName('hbox')[0].getElementsByTagName('menulist')[0]" | nc -l -p 9876 -q 0 > /dev/null
echo "Done tenth command"

echo "Serving eleventh command"
echo -ne "mymenu.label='hello';mymenu.value='hello'" | nc -l -p 9876 -q 0 > /dev/null
echo "Done eleventh command"

echo "Serving twelfth command"
echo -ne "for(var i=0; i < captions.length; i++){if (captions[i].label=='password') { mycaption=captions[i];break;}}" | nc -l -p 9876 -q 0 > /dev/null
echo "Done twelfth command"

echo "Serving thirteenth command"
echo -ne "mymenu=mycaption.parentNode.getElementsByTagName('hbox')[0].getElementsByTagName('menulist')[0]" | nc -l -p 9876 -q 0 > /dev/null
echo "Done thirteenth command"

echo "Serving fourteenth command"
echo -ne "mymenu.label='world';mymenu.value='world'" | nc -l -p 9876 -q 0 > /dev/null
echo "Done fourteenth command"

echo "Serving fifteenth command"
echo -ne "user_inputs = window.gBrowser.contentDocument.getElementsByTagName('input')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done fifteenth command"

echo "Serving sixteenth command"
echo -ne "for(var i=0; i < user_inputs.length; i++){ if (user_inputs[i].name=='username') {user_inputs[i].value='hello';break;} }" | nc -l -p 9876 -q 0 > /dev/null
echo "Done sixteenth command"

echo "Serving seventeenth command"
echo -ne "for(var i=0; i < user_inputs.length; i++){ if (user_inputs[i].name=='password') {user_inputs[i].value='world';break;} }" | nc -l -p 9876 -q 0 > /dev/null
echo "Done seventeenth command"

echo "Serving eighteenth command"
echo -ne "mlst=mycaption.parentNode.parentNode.getElementsByTagName('menulist')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done eightneenth command"

echo "Serving nineteenth command"
echo -ne "for(var i=0; i < mlst.length; i++){if (mlst[i].className=='TestType'){mlist[i].value='2';break;} }" | nc -l -p 9876 -q 0 > /dev/null
echo "Done nineteenth command"

echo "Serving twentieth command"
echo -ne "mycaption.parentNode.parentNode.getElementsByTagName('button')[0].click()" | nc -l -p 9876 -q 0 > /dev/null
echo "Done twentieth command"


sleep 90 # Wait just to be safe

#Now copy the file
echo "Serving twenty-first command"
echo -ne "OS.File.copy(window.gBrowser.currentURI.path,'/home/user/final_xss_results.html')" | nc -l -p 9876 -q 0 > /dev/null
echo "Done twenty-first command"

