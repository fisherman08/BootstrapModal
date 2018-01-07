Bootstrapのmodalを呼び出すjsライブラリ

を作りました。正確に言えば以前に作ったものを思いつきでCoffeescriptに書き直したのでついでにgithubに公開してみました。
bootstrapのモーダルは見栄えも良くて各ブラウザでの確認ウインドウの差異を吸収するのに愛用するんですが、
素直にhtmlを書こうとするとdivが何重にもネストしたりして面倒なので。

#BootstrapModal
[https://github.com/fisherman08/BootstrapModal](https://github.com/fisherman08/BootstrapModal "")


* モーダルのタイトル、本文を指定できます。本文はjQueryオブジェクトも受け取ります
* 任意の数のボタンをそれぞれコールバック付きで作成できます。bootstrapのボタンのクラス(info,success,warning,danger)を指定できます。標準ではdefaultになります。
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

ただこれだけです。非常に簡単なライブラリですが、あると便利。
バグやツッコミどころはかなりあると思うので、もしお気付きの方がいらっしゃいましたらここかgithubでご指摘ください。。
もちろんpull-requestも大歓迎です。
[https://github.com/fisherman08/BootstrapModal](https://github.com/fisherman08/BootstrapModal "")

