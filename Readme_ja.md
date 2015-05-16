# BootstrapModal
https://github.com/ky0314/BootstrapModal


v1.0.0

Bootstrap3.x系のモーダルウインドウをjavascriptだけで呼び出すファンクションです。
いちいちdivなどを何重にもマークアップするのが面倒なので自分用に作成しました

* モーダルのタイトル、本文を指定できます。本文はjQueryオブジェクトも受け取ります
* 任意の数のボタンをそれぞれおコールバック付きで作成できます
* モーダルのロックなどのオプションもあります

## 使用方法:
.jsファイルを読み込むだけです

```html:example.html
<script src="bs_modal.js"></script>

```

## simple example :
window.alert()を置き換えるだけなら以下の1行でできます

```javascriipt:example.js
   BootStrapModal.call({"title":"success", "body":"Data successfully updated"});
```

## another example with full-options :
色々オプションをつけてボタンをたくさん載せると以下の感じになります。
各オプションの詳細はコメントを見てください。すいません。。。

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