package com.example.platform_channel

import android.app.AlertDialog
import android.app.Dialog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "DIALOG"
    private val METHOD = "showDialog"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messanger = flutterEngine.dartExecutor.binaryMessenger
        val methodChannel = MethodChannel(messanger, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->

            if(call.method == METHOD){
                // create an alert dialog for messanger
                val message = call.arguments
                AlertDialog.Builder(this).setTitle(message.toString()).create().show();
            }
            val temp = "{ \"userId\": 1, \"id\": 1, \"title\": \"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\", \"body\": \"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\" }"
            result.success(temp)
        }

        }
    }


