package com.pehlivanov.zlati.flutter_id3_reader

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.view.FlutterNativeView


/**
 * FlutterId3Plugin
 */
class FlutterId3ReaderPlugin : FlutterPlugin {
    private var channel: MethodChannel? = null
    private var methodCallHandler: MainMethodCallHandler? = null
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        startListening(binding.applicationContext, binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        stopListening()
    }

    private fun startListening(applicationContext: Context, messenger: BinaryMessenger) {
        methodCallHandler = MainMethodCallHandler(applicationContext, messenger)
        channel = MethodChannel(messenger, "com.pehlivanov.zlati.flutter_id3_reader.methods")
        channel!!.setMethodCallHandler(methodCallHandler)
    }

    private fun stopListening() {
        methodCallHandler = null
        channel!!.setMethodCallHandler(null)
    }

    companion object {
        /**
         * v1 plugin registration.
         */
        fun registerWith(registrar: Registrar) {
            val plugin = FlutterId3ReaderPlugin()
            plugin.startListening(registrar.context(), registrar.messenger())
            registrar.addViewDestroyListener { _: FlutterNativeView? ->
                plugin.stopListening()
                false
            }
        }
    }
}