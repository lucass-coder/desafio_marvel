package com.desafiomarvel.desafio_marvel

import android.os.Bundle
import com.google.firebase.analytics.FirebaseAnalytics
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.desafiomarvel.desafio_marvel/analytics"

    private lateinit var firebaseAnalytics: FirebaseAnalytics

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        

        firebaseAnalytics = FirebaseAnalytics.getInstance(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            
            if (call.method == "logEvent") {
                try {
                    val name = call.argument<String>("name")
                    val parameters = call.argument<Map<String, Any>>("parameters")
                    
                    if (name != null) {
                        val bundle = Bundle()
                        parameters?.forEach { (key, value) ->
                            bundle.putString(key, value.toString())
                        }
                        
                        firebaseAnalytics.logEvent(name, bundle)
                        
                        result.success("Evento '$name' registrado com sucesso.")
                    } else {
                        result.error("INVALID_ARGUMENT", "O nome do evento não pode ser nulo.", null)
                    }
                } catch (e: Exception) {
                    result.error("NATIVE_ERROR", "Erro ao registrar evento: ${e.message}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}