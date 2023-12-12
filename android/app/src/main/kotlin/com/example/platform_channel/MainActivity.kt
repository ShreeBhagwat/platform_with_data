package com.example.platform_channel

import android.app.AlertDialog
import android.app.Dialog
import android.database.Observable
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import android.os.Handler
import java.text.SimpleDateFormat
import java.util.Date

class MainActivity: FlutterActivity() {
    private val CHANNEL = "DIALOG"
    private val METHOD = "showDialog"



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messanger = flutterEngine.dartExecutor.binaryMessenger
        val eventChannel = EventChannel(messanger, "event_channel");
        val myEventChannel =  EventChannelhandler();
        myEventChannel.sendEvent("Event channel data sent");
        eventChannel.setStreamHandler(myEventChannel)

        val methodChannel = MethodChannel(messanger, CHANNEL)

        eventChannel.setStreamHandler(myEventChannel);


        }



    }


class EventChannelhandler : EventChannel.StreamHandler{


     private var handler = Handler(Looper.getMainLooper());
     var eventSink : EventChannel.EventSink? = null;
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
       print("onListen")
        eventSink = events;

        val r: Runnable = object : Runnable{
            override fun run(){
                handler.post {
                    val dateFormat = SimpleDateFormat("hh:mm:ss")
                    val time = dateFormat.format(Date())
                    eventSink?.success(time)
                }
                handler.postDelayed(this, 1000)
            }
        }
        handler.postDelayed(r, 1000)
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null;
    }

    fun sendEvent( eventData: Any){
        if(eventSink != null){
            eventSink!!.success(eventData)

        }

     }

}

