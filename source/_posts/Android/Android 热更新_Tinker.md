---
title: Android 热更新_Tinker
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


说明：TinkerPatch和Tinker并不是一个东西。TinkerPatch支持在线更新
想看TinkerPatch的点这个http://www.jianshu.com/p/4fbb7a5025df
[http://www.jianshu.com/p/ad7deea62a07](https://www.jianshu.com/p/ad7deea62a07)

官方指南：https://github.com/Tencent/tinker/wiki/Tinker-%E6%8E%A5%E5%85%A5%E6%8C%87%E5%8D%97
大神资料：https://juejin.im/post/5a27bdaf6fb9a044fa19bcfc

视频教程
http://v.youku.com/v_show/id_XMzIzMTU2MjAyMA==.html?spm=a2h3j.8428770.3416059.1

一.  进入官网 http://www.tinkerpatch.com/
第三步才是重点。。。TinkerPatch 和Tinker好像不是一个 Fuck
![image.png](http://upload-images.jianshu.io/upload_images/2803682-bd5a5f1aec704d41.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

二. 新建项目 
1. 项目的build.gradle中
```
buildscript {
    dependencies {
        classpath ('com.tencent.tinker:tinker-patch-gradle-plugin:1.9.1')
    }
}
```
2. app的build.gradle中
```
dependencies {
    implementation "com.android.support:multidex:1.0.2"
    //tinker的核心库
    implementation("com.tencent.tinker:tinker-android-lib:1.9.1") { changing = true }
    //可选，用于生成application类
    annotationProcessor("com.tencent.tinker:tinker-android-anno:1.9.1") { changing = true }
    compileOnly("com.tencent.tinker:tinker-android-anno:1.9.1") { changing = true }
}
```
3.  开启multiDex
```
defaultConfig {
		...
        multiDexEnabled true
}
```
4. app的build.gradle中额外配置(针对步骤6 BuildConfig 报错问题)
```
buildConfigField "String", "MESSAGE", "\"I am the base apk\""
buildConfigField "String", "TINKER_ID", "\"${getTinkerIdValue()}\""
buildConfigField "String", "PLATFORM", "\"all\""
```
5. 配置app的build.gradle(不要管为什么 我也不知道。。。)
```
// Tinker配置与任务
def bakPath = file("${buildDir}/bakApk/")
ext {
    // 是否使用Tinker(当你的项目处于开发调试阶段时，可以改为false)
    tinkerEnabled = true
    // 基础包文件路径（名字这里写死为old-app.apk。用于比较新旧app以生成补丁包，不管是debug还是release编译）
    tinkerOldApkPath = "${bakPath}/old-app.apk"
    // 基础包的mapping.txt文件路径（用于辅助混淆补丁包的生成，一般在生成release版app时会使用到混淆，所以这个mapping.txt文件一般只是用于release安装包补丁的生成）
    tinkerApplyMappingPath = "${bakPath}/old-app-mapping.txt"
    // 基础包的R.txt文件路径（如果你的安装包中资源文件有改动，则需要使用该R.txt文件来辅助生成补丁包）
    tinkerApplyResourcePath = "${bakPath}/old-app-R.txt"
    //only use for build all flavor, if not, just ignore this field
    tinkerBuildFlavorDirectory = "${bakPath}/flavor"
}

def getOldApkPath() {
    return hasProperty("OLD_APK") ? OLD_APK : ext.tinkerOldApkPath
}

def getApplyMappingPath() {
    return hasProperty("APPLY_MAPPING") ? APPLY_MAPPING : ext.tinkerApplyMappingPath
}

def getApplyResourceMappingPath() {
    return hasProperty("APPLY_RESOURCE") ? APPLY_RESOURCE : ext.tinkerApplyResourcePath
}

def getTinkerIdValue() {
    return hasProperty("TINKER_ID") ? TINKER_ID : android.defaultConfig.versionName
}

def buildWithTinker() {
    return hasProperty("TINKER_ENABLE") ? TINKER_ENABLE : ext.tinkerEnabled
}

def getTinkerBuildFlavorDirectory() {
    return ext.tinkerBuildFlavorDirectory
}

if (buildWithTinker()) {
    //apply tinker插件
    apply plugin: 'com.tencent.tinker.patch'

    // 全局信息相关的配置项
    tinkerPatch {
        tinkerEnable = buildWithTinker()// 是否打开tinker的功能。
        oldApk = getOldApkPath()        // 基准apk包的路径，必须输入，否则会报错。
        ignoreWarning = false           // 是否忽略有风险的补丁包。这里选择不忽略，当补丁包风险时会中断编译。
        useSign = true                  // 在运行过程中，我们需要验证基准apk包与补丁包的签名是否一致，我们是否需要为你签名。
        // 编译相关的配置项
        buildConfig {
            applyMapping = getApplyMappingPath()
            // 可选参数；在编译新的apk时候，我们希望通过保持旧apk的proguard混淆方式，从而减少补丁包的大小。这个只是推荐设置，不设置applyMapping也不会影响任何的assemble编译。
            applyResourceMapping = getApplyResourceMappingPath()
            // 可选参数；在编译新的apk时候，我们希望通过旧apk的R.txt文件保持ResId的分配，这样不仅可以减少补丁包的大小，同时也避免由于ResId改变导致remote view异常。
            tinkerId = getTinkerIdValue()
            // 在运行过程中，我们需要验证基准apk包的tinkerId是否等于补丁包的tinkerId。这个是决定补丁包能运行在哪些基准包上面，一般来说我们可以使用git版本号、versionName等等。
            keepDexApply = false
            // 如果我们有多个dex,编译补丁时可能会由于类的移动导致变更增多。若打开keepDexApply模式，补丁包将根据基准包的类分布来编译。
            isProtectedApp = false // 是否使用加固模式，仅仅将变更的类合成补丁。注意，这种模式仅仅可以用于加固应用中。
            supportHotplugComponent = false // 是否支持新增非export的Activity（1.9.0版本开始才有的新功能）
        }
        // dex相关的配置项
        dex {
            dexMode = "jar"
// 只能是'raw'或者'jar'。 对于'raw'模式，我们将会保持输入dex的格式。对于'jar'模式，我们将会把输入dex重新压缩封装到jar。如果你的minSdkVersion小于14，你必须选择‘jar’模式，而且它更省存储空间，但是验证md5时比'raw'模式耗时。默认我们并不会去校验md5,一般情况下选择jar模式即可。
            pattern = ["classes*.dex",
                       "assets/secondary-dex-?.jar"]
            // 需要处理dex路径，支持*、?通配符，必须使用'/'分割。路径是相对安装包的，例如assets/...
            loader = [
                    // 定义哪些类在加载补丁包的时候会用到。这些类是通过Tinker无法修改的类，也是一定要放在main dex的类。
                    // 如果你自定义了TinkerLoader，需要将它以及它引用的所有类也加入loader中；
                    // 其他一些你不希望被更改的类，例如Sample中的BaseBuildInfo类。这里需要注意的是，这些类的直接引用类也需要加入到loader中。或者你需要将这个类变成非preverify。
            ]
        }
        // 	lib相关的配置项
        lib {
            pattern = ["lib/*/*.so","src/main/jniLibs/*/*.so"]
            // 需要处理lib路径，支持*、?通配符，必须使用'/'分割。与dex.pattern一致, 路径是相对安装包的，例如assets/...
        }
        // res相关的配置项
        res {
            pattern = ["res/*", "assets/*", "resources.arsc", "AndroidManifest.xml"]
            // 需要处理res路径，支持*、?通配符，必须使用'/'分割。与dex.pattern一致, 路径是相对安装包的，例如assets/...，务必注意的是，只有满足pattern的资源才会放到合成后的资源包。
            ignoreChange = [
                    // 支持*、?通配符，必须使用'/'分割。若满足ignoreChange的pattern，在编译时会忽略该文件的新增、删除与修改。 最极端的情况，ignoreChange与上面的pattern一致，即会完全忽略所有资源的修改。
                    "assets/sample_meta.txt"
            ]
            largeModSize = 100
            // 对于修改的资源，如果大于largeModSize，我们将使用bsdiff算法。这可以降低补丁包的大小，但是会增加合成时的复杂度。默认大小为100kb
        }
        // 用于生成补丁包中的'package_meta.txt'文件
        packageConfig {
            // configField("key", "value"), 默认我们自动从基准安装包与新安装包的Manifest中读取tinkerId,并自动写入configField。
            // 在这里，你可以定义其他的信息，在运行时可以通过TinkerLoadResult.getPackageConfigByName得到相应的数值。
            // 但是建议直接通过修改代码来实现，例如BuildConfig。
            configField("platform", "all")
            configField("patchVersion", "1.0")
//            configField("patchMessage", "tinker is sample to use")
        }
        // 7zip路径配置项，执行前提是useSign为true
        sevenZip {
            zipArtifact = "com.tencent.mm:SevenZip:1.1.10"
        }
    }
    List<String> flavors = new ArrayList<>();
    project.android.productFlavors.each { flavor ->
        flavors.add(flavor.name)
    }
    boolean hasFlavors = flavors.size() > 0
    def date = new Date().format("MMdd-HH-mm-ss")

    /**
     * bak apk and mapping
     */
    android.applicationVariants.all { variant ->
        /**
         * task type, you want to bak
         */
        def taskName = variant.name

        tasks.all {
            if ("assemble${taskName.capitalize()}".equalsIgnoreCase(it.name)) {

                it.doLast {
                    copy {
                        def fileNamePrefix = "${project.name}-${variant.baseName}"
                        def newFileNamePrefix = hasFlavors ? "${fileNamePrefix}" : "${fileNamePrefix}-${date}"

                        def destPath = hasFlavors ? file("${bakPath}/${project.name}-${date}/${variant.flavorName}") : bakPath
                        from variant.outputs.first().outputFile
                        into destPath
                        rename { String fileName ->
                            fileName.replace("${fileNamePrefix}.apk", "${newFileNamePrefix}.apk")
                        }

                        from "${buildDir}/outputs/mapping/${variant.dirName}/mapping.txt"
                        into destPath
                        rename { String fileName ->
                            fileName.replace("mapping.txt", "${newFileNamePrefix}-mapping.txt")
                        }

                        from "${buildDir}/intermediates/symbols/${variant.dirName}/R.txt"
                        into destPath
                        rename { String fileName ->
                            fileName.replace("R.txt", "${newFileNamePrefix}-R.txt")
                        }
                    }
                }
            }
        }
    }
    project.afterEvaluate {
        //sample use for build all flavor for one time
        if (hasFlavors) {
            task(tinkerPatchAllFlavorRelease) {
                group = 'tinker'
                def originOldPath = getTinkerBuildFlavorDirectory()
                for (String flavor : flavors) {
                    def tinkerTask = tasks.getByName("tinkerPatch${flavor.capitalize()}Release")
                    dependsOn tinkerTask
                    def preAssembleTask = tasks.getByName("process${flavor.capitalize()}ReleaseManifest")
                    preAssembleTask.doFirst {
                        String flavorName = preAssembleTask.name.substring(7, 8).toLowerCase() + preAssembleTask.name.substring(8, preAssembleTask.name.length() - 15)
                        project.tinkerPatch.oldApk = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-release.apk"
                        project.tinkerPatch.buildConfig.applyMapping = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-release-mapping.txt"
                        project.tinkerPatch.buildConfig.applyResourceMapping = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-release-R.txt"

                    }
                }
            }

            task(tinkerPatchAllFlavorDebug) {
                group = 'tinker'
                def originOldPath = getTinkerBuildFlavorDirectory()
                for (String flavor : flavors) {
                    def tinkerTask = tasks.getByName("tinkerPatch${flavor.capitalize()}Debug")
                    dependsOn tinkerTask
                    def preAssembleTask = tasks.getByName("process${flavor.capitalize()}DebugManifest")
                    preAssembleTask.doFirst {
                        String flavorName = preAssembleTask.name.substring(7, 8).toLowerCase() + preAssembleTask.name.substring(8, preAssembleTask.name.length() - 13)
                        project.tinkerPatch.oldApk = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-debug.apk"
                        project.tinkerPatch.buildConfig.applyMapping = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-debug-mapping.txt"
                        project.tinkerPatch.buildConfig.applyResourceMapping = "${originOldPath}/${flavorName}/${project.name}-${flavorName}-debug-R.txt"
                    }
                }
            }
        }
    }
}
```

6. 复制文件
打开Tinker Github： https://github.com/Tencent/tinker
选择
![image.png](http://upload-images.jianshu.io/upload_images/2803682-27fee21c53cf5629.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-b69c66bf28af8377.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
将这六个文件夹复制到你的项目中 app中的MainActivity删掉就行，用自己的

7. 配置Application
修改app/SampleApplicationLike 总之：图一的application名字对应manifest 中的即可，开始会有报错，build 项目后自动生成
![image.png](http://upload-images.jianshu.io/upload_images/2803682-903a7bc815448d21.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
配置mainfest文件
![image.png](http://upload-images.jianshu.io/upload_images/2803682-50c2034c80f36449.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
添加服务
```
<service
    android:name=".......service.SampleResultService"
    android:exported="false"/>
```
最后权限 一定要加，否则更新读取本地会失败
```
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```
8.  MianActivity中
布局只需要一个TextView即可，默认显示Hello World!
```
TextView tv=findViewById(R.id.tv);
//tv.setText("这是更新后的数据");
tv.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View view) {
        //安装更新
        TinkerInstaller.onReceiveUpgradePatch(MainActivity.this,
                Environment.getExternalStorageDirectory()+"/patch_signed_7zip.apk");
    }
});
```

三. 构建基础包
不要直接安装或者使用AS打包，AS右边选择这个
![image.png](http://upload-images.jianshu.io/upload_images/2803682-e11959fbc8e55ba1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

成功后 切换到project试图
![image.png](http://upload-images.jianshu.io/upload_images/2803682-04d30f7f2dc8d0f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后安装这个app即可
界面如下
![image.png](http://upload-images.jianshu.io/upload_images/2803682-ab513601dea4dd4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 四. 构建补丁包 
MainActivity中的注释打开
![image.png](http://upload-images.jianshu.io/upload_images/2803682-25b473c0232f60bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

修改包名,刚才安装的基础包重命名
![image.png](http://upload-images.jianshu.io/upload_images/2803682-d367022d132e491d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
和app build.grald下的这个名字一样即可
![image.png](http://upload-images.jianshu.io/upload_images/2803682-980f9ad901642b97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
这次选择tinker目录下的打补丁包
![image.png](http://upload-images.jianshu.io/upload_images/2803682-c636f72606247ca8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-d0c7f51a56b4db7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
成功后，复制patch_signed_7zip.apk 到手机根目录
运行app，点击文本，成功后提示如下
![](http://upload-images.jianshu.io/upload_images/2803682-fe016b6ad935eca2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
关闭App，后台也关闭、后台也关闭、后台也关闭，重启见证奇迹
![image.png](http://upload-images.jianshu.io/upload_images/2803682-646dc1e93a632870.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

项目demo地址：https://gitee.com/lrxcandroid/LrxcTinker.git






