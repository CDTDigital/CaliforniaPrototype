package com.hotb.pgmacdesign.californiaprototype.listeners;

import android.support.annotation.NonNull;
import android.view.View;

import com.hotb.pgmacdesign.californiaprototype.misc.L;
import com.hotb.pgmacdesign.californiaprototype.misc.Constants;


/**
 * This class serves as a click listener that can be implemented instead of just adding on the
 * standard click listener. It is mostly useful when using tools like recyclerviews and listviews
 * as it sends back the object as well as other things (like position) if you deem it necessary.
 * Created by pmacdowell on 2017-02-13.
 */
public class CustomClickListener  implements View.OnClickListener{

    private CustomClickCallbackLink link;
    private Integer customTag;
    private Integer position;
    private Object obj;

    /**
     * Constructor (overloaded). See description below
     * @param link
     * @param customTag
     */
    public CustomClickListener(@NonNull CustomClickCallbackLink link, Integer customTag){
        this.link = link;
        this.customTag = customTag;
        this.obj = null;
        this.position = null;
    }

    /**
     * Constructor (overloaded). See description below
     * @param link
     * @param customTag
     * @param obj
     */
    public CustomClickListener(@NonNull CustomClickCallbackLink link, Integer customTag, Object obj){
        this.link = link;
        this.customTag = customTag;
        this.obj = obj;
        this.position = null;
    }

    /**
     * Constructor
     * @param link The CustomCallbackLink object to send data back on to
     * @param customTag The integer custom tag. Use this for sending back specific tags that you
     *                  want to reference and differentiate between.
     * @param obj Object(s) being sent back. if you want, you can use if(obj instanceof XX)
     *                  and use that as a separator.
     * @param position The integer position. This would be utilized in a recyclerview or listview
     *                 where you want to know the position of the list in order to re-update it
     *                 somehow. (IE calling adapter.updateOneObject() and passing in the position.
     */
    public CustomClickListener(@NonNull CustomClickCallbackLink link, Integer customTag, Object obj, Integer position){
        this.link = link;
        this.customTag = customTag;
        this.obj = obj;
        this.position = position;
    }

    @Override
    public void onClick(View view) {
        if(link == null){
            L.m("Null Custom Click Callback Link. Did you forget to initialize it?");
            return;
        }
        if(customTag == null){
            this.customTag = Constants.TAG_CLICK_NO_TAG_SENT;
        }
        link.itemClicked(obj, customTag, position);
    }
}