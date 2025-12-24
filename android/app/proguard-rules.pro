# ProGuard rules for FMA Pontos

# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Supabase
-keep class io.supabase.** { *; }
-keep class com.google.gson.** { *; }
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# AudioPlayers
-keep class xyz.luan.audioplayers.** { *; }

# Audio Service
-keep class com.ryanheise.audioservice.** { *; }

# Keep model classes (prevent obfuscation of field names used in JSON)
-keepclassmembers class * {
    @com.google.gson.annotations.Expose <fields>;
}

# OkHttp (usado pelo Supabase)
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }

# Suppress warnings for missing optional deps
-dontwarn java.lang.invoke.**
-dontwarn javax.annotation.**
