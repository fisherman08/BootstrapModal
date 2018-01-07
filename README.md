# BootstrapModal
https://github.com/fisherman08/BootstrapModal


v1.0.0

A javascript class to call Bootstrap3.x modal window via javascript, without writing nested and nested DIVs

* modal title, body. body can also receive a jqueru object in addition to string
* buttons with callbacks and bootstrap button classes(info,success,warning,danger)
* locking modal window

## USAGE:
just load the .js file

```html:example.html
<script src="bs_modal.js"></script>

```

## simple example :
easiest example which can be alternative of window.alert()

```javascriipt:example.js
   BootStrapModal.call({"title":"success", "body":"Data successfully updated"});
```

## another example with full-options :
details of each option are written in the code

```javascript:example.js

   // "body" option can receive a String or a jQuery object
   var $p = $('<p/>').text('Are you sure to delete the data?');
   
   
   BootStrapModal.call(
        {
            "title"  : "delete the data", // the title put at the header(String)
            "body"   : $p, // the main message of the modal window(String or jQuery object)
            "fade"   : true, // if true, the modal window appears by fading(Boolean)
            "static" : true, // if true, the modal window WILL NOT BE DISAPPEARED when background is clicked or ESC is pressed.(Boolean)
            "id"     : "", //
            "actions" :[ // Array of objects to create buttons
                        {
                            "label": "Cancel",
                            "type": "default",
                            "class_str": "",
                            "close": true,
                            "callback": function(modal){
                                     // the function to be executed when the button is clicked
                                     // this function will receive the instance of modal class, which has "close()" method to close the modal.
                                     // when you set the "close:false", do not forget to call "modal.close()" at the last of the function
                            }
                        },
                        {
                            "label": "Delete",
                            "type": "danger",
                            "class_str": "",
                            "close": false,
                            "callback": function(modal){
                                    alert("delete!");
                                    modal.close();
                            }
                        }
                        ]
        }
    );
```

## history
### v1.0.0
* released