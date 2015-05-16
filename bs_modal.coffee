###

BootStrapModal
    v1.0.0

Copyright (c) 2015 Y.Kaneko
    https://github.com/ky0314/BootstrapModal

This software is released under the MIT License.
http://opensource.org/licenses/mit-license.php

Requirement:
   Bootstrap 3.X and jQuery


USAGE:
just load the .js file
<script src="bs_modal.js"></script>

simple example :
   BootStrapModal.call({"title":"success", "body":"Data successfully updated"});
 

another example with full-options :
   BootStrapModal.call(
        {
            "title"  : "delete the data", // the title put at the header(String)
            "body"   : "Are you sure to delete the data? ", // the main message of the modal window(String or jQuery object)
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

###

window.BootStrapModal = {}
BootstrapModal = window.BootStrapModal

BootStrapModal.call = (options_in) ->
    new BootStrapModal.modal_builder options_in

class BootstrapModal.modal_builder
    options =
        "title" : null, # the title put at the header(String)
        "body"  : null, # the main message of the modal window(String or jQuery object)
        "fade"  : true, # if true, the modal window appears by fading(Boolean)
        "static": false, # if true, the modal window WILL NOT BE DISAPPEARED when background is clicked.(Boolean)
        "id"    : null,
        "actions": [# Array of objects to create buttons
            {
                "label": "OK", # the text of button(String)
                "type": "default", # type of bootstrap buttons "info, success, warning, danger, default" (String)
                "class_str": "", # additional class name to be added to the button element(String)
                "close": true, # if false, the modal window WILL NOT BE DISAPPEARED after the given callback is executed.(Boolean)
                "callback": (modal) ->
                    # the function to be executed when the button is clicked
                    # this function will receive the instance of modal class, which has "close()" method to close the modal.
                    # when you set the "close:false", do not forget to call "modal.close()" at the last of the function
            }

        ]


    constructor: (options_in) ->
        @options = $.extend(true, options, options_in)
        @id = if options.id? then options.id else "BootStrapModalInstance"
        @$html = null
        @buttons = {}
        build_html.call @
        @show()

    show :()->
        ops = {
            "show" : true
        }
        if @options["static"] is true
            ops["backdrop"] = "static"
            ops["keyboard"] = false

        @$html.modal(ops)

    close : ()->
        @$html.modal("hide")

    # build modal-div jquery object, and set it as property "$html"
    # private
    build_html = ()->
        $modal_content = $("<div/>").addClass("modal-content")

        # header
        $modal_header = $("<div/>").addClass("modal-header").append(
            $("<button/>").addClass("close")
            .attr({"type": "button", "data-dismiss": "modal", "aria-label": "close"})
            .append(
                $("<span/>").attr({"aria-hidden": "true"}).html("&times;")
            )
        )
        $modal_header.find("button").remove() if @options["static"] is true

        # append the title to the header if exists
        if @options.title? and typeof @options.title is "string"
            $modal_header.append(
                $("<h4/>").text(@options.title)
            );

        # append to modal-content div
        $modal_content.append($modal_header)

        # body
        $modal_body = $("<div/>").addClass("modal-body")
        if @options.body instanceof jQuery
            $modal_body.append @options.body
        else if typeof @options.body is "string"
            $modal_body.text @options.body

        $modal_content.append($modal_body)

        # footer
        $modal_content.append(build_footer.call(@))

        $modal = $("<modal/>").addClass("modal").append(
            $("<div/>").addClass("modal-dialog").append(
                $modal_content
            )
        )

        $modal.addClass("fade") if @options.fade is true

        @$html = $modal

    build_footer = ()->
        actions = options.actions
        $div = $("<div/>").addClass("modal-footer")

        for act in actions
            continue unless act? and typeof act is "object"

            btn = new BootStrapModal.button(@, act)
            $div.append(btn.get_html())
            @buttons[act.id] = btn

        return $div


 # class for each button
 # usually, you do not have to use this class directly.
 # instances of this class will be registered to "buttons" property of modal_builder class.
 #
 # @param modal_in
 # @param options_in
 #
class BootstrapModal.button
    constructor: (modal_in, options_in)->
        @modal = modal_in
        @id = options_in.id ||""
        @label = options_in.label || ""
        @type  = options_in.type  || "default"
        @class_str = options_in.class_str || ""
        @close = !(options_in.close is false)
        @callback = options_in.callback || ()->

        build_html.call @

    get_html : ()->
        @$html

    build_html = ()->
        $btn = $("<button/>").attr({"type": "button"}).addClass("btn")

        # set label
        $btn.text @label

        # set bootstrap btn type(default, info, success, warning, danger)
        switch @type
            when "info"
                $btn.addClass("btn-info")
            when "success"
                $btn.addClass("btn-success")
            when "warning"
                $btn.addClass("btn-warning")
            when "danger"
                $btn.addClass("btn-danger")
            else
                $btn.addClass("btn-default")

        # set additional class
        $btn.addClass @class_str if @class_str? and typeof @class_str is "string"

        # bind the callback
        self = @
        $btn.click ()->
            # execute callback given
            self.callback?(self.modal)
            # close modal when close-option is true
            self.modal.close() if self.close is true

        @$html = $btn



        
