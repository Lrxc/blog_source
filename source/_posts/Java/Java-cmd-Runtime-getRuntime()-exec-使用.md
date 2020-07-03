---
title: Java-cmd-Runtime-getRuntime()-exec-使用
date: 2019-07-01 16:01:33
categories: Java
tags: java
---


##一 使用方式
1. 基本操作
```
//显示目录结构
String s11 = "cmd /c dir";
//新窗口执行dir---start
String s12 = "cmd /c start dir";
//新窗口执行dir后不关闭
String s13 = "cmd /k start dir";
```
2. 执行多条命令
```
//显示目录结构，然后显示路径
String s21 = "cmd /c dir & cd";
//进入E盘，进入ftp目录，显示路径
String s22 = "cmd /c e: & cd ftp & cd
//新窗口执行---start
String s23 = "cmd /c start dir & cd";
```

3. 执行脚本
```
//文件路径
File file = new File("D:/Debug/b.bat");
String s31 = "cmd /c " + file.getAbsolutePath();
// start  新窗口执行
String s32 = "cmd /c start " + file.getAbsolutePath();
```
脚本b.bat 内容如下
```
E:
cd ftp
dir
```

4. 启动指定软件
```
//可以打开新cmd窗口，能用git命令
String s41 = "cmd /c start \"myname\" \"C:\\Java\\PortableGit\\bin\\bash.exe\"";
//可以打开新cmd窗口，但是不能用git命令
String s42 = "cmd /c start \"C:\\Java\\PortableGit\\bin\\bash.exe\"";
//直接打开，部分软件能成功，cmd窗口会卡住
String s43 = "\"C:\\Java\\PortableGit\\bin\\bash.exe\"";
```

5. 启动指定软件并传递参数
```
//重点( -c 是启动参数 ) --  启动指定软件，并传递命令( -c 后面用双引号，表示一个命令)
String s44 = "\"C:\\Java\\PortableGit\\bin\\bash.exe\" -c \"git --version\"";
//同上 -- 但是加了 start 后有问题
String[] s45 = {"\"C:\\Java\\PortableGit\\bin\\bash.exe\"","-c","start","git --version"};
```

6. 需要指定path环境变量envp
```
String s51="cmd /c git --version";
//配置path环境变量
String[] envp = {"Path=C:\\Java\\PortableGit\\bin"};
//执行
Runtime.getRuntime().exec(s51,envp);
```
##二 代码集成
1. 代码使用
```
//执行命令
Process process = Runtime.getRuntime().exec(cmd);
//等待执行完毕
process.waitFor();
//执行结果，0是正常
int value = process.exitValue();
System.out.println(value);

//输出信息
InputStreamReader is = new InputStreamReader(process.getInputStream(), Charset.forName("GBK"));
BufferedReader br = new BufferedReader(is);
String line;
while ((line = br.readLine()) != null) {
    System.out.println(line);
}
//错误信息
is = new InputStreamReader(process.getErrorStream(), Charset.forName("GBK"));
br = new BufferedReader(is);
while ((line = br.readLine()) != null) {
    System.out.println(line);
}
//关闭连接(最好放在finally中)
process.destroy();
```
2.  ProcessBuilder 执行命令，打开软件
```
try {
    //启动 windows 的计算器程序，第一个参数必须是可执行程序
    String[] cmd1 = {"C:/Java/PortableGit/bin/bash.exe", "-c", "git"};
    /** 创建ProcessBuilder对象，设置指令列表*/
    ProcessBuilder processBuilder = new ProcessBuilder(cmd1);
    processBuilder.redirectErrorStream(true);
    Process process = processBuilder.start();
    InputStream in = process.getInputStream();
    byte[] re = new byte[1024];
    while (in.read(re) != -1) {
        System.out.println("==>" + new String(re, Charset.forName("GBK")));
    }
    in.close();
    if (process.isAlive()) {
        process.waitFor();
    }
} catch (Exception e) {
    e.printStackTrace();
}
```
3 .   只能打开软件
```
try {
    Desktop desktop = Desktop.getDesktop();
    File file = new File("C:/Windows/system32/cmd.exe");
    desktop.open(file);
} catch (IOException e) {
    e.printStackTrace();
}
```

##三 完整代码
```
import java.awt.*;
import java.io.*;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class Test {

    public static void main(String[] args) {
        Process process = null;
        try {
            /**-----基本命令-------**/
            String s11 = "cmd /c dir";
            //新窗口执行dir---start
            String s12 = "cmd /c start dir";
            //新窗口执行dir后不关闭
            String s13 = "cmd /k start dir";

            /**-----多条命令-------**/
            String s21 = "cmd /c dir & cd";
            String s22 = "cmd /c e: & cd ftp & cd";
            //新窗口执行---start
            String s23 = "cmd /c start dir & cd";

            /**-----bat脚本-------**/
            File file = new File("D:/Debug/b.bat");
            String s31 = "cmd /c " + file.getAbsolutePath();
            String s32 = "cmd /c start " + file.getAbsolutePath();

            /**------启动指定软件------**/
            //可以打开新cmd窗口，能用git命令
            String s41 = "cmd /c start \"myname\" \"C:\\Java\\PortableGit\\bin\\bash.exe\"";
            //可以打开新cmd窗口，但是不能用git命令
            String s42 = "cmd /c start \"C:\\Java\\PortableGit\\bin\\bash.exe\"";
            //直接打开，部分成功，会卡住
            String s43 = "\"C:\\Java\\PortableGit\\bin\\bash.exe\"";
            //重点( -c ) --  启动指定软件，并传递命令( -c 后面用双引号，表示一个命令)
            String s44 = "\"C:\\Java\\PortableGit\\bin\\bash.exe\" -c \"git --version\"";
            //同上 -- 但是加了 start 后有问题
            String[] s45 = {"\"C:\\Java\\PortableGit\\bin\\bash.exe\"", "-c", "start", "git --version"};

            /**------需要指定path环境变量envp------**/
            String s51 = "cmd /c git --version";
            //配置path环境变量
            String[] envp = {"Path=C:\\Java\\PortableGit\\bin"};

            process = Runtime.getRuntime().exec(s45);
            process.waitFor();
            int value = process.exitValue();
            System.out.println(value);

            InputStreamReader is = new InputStreamReader(process.getInputStream(), Charset.forName("GBK"));
            BufferedReader br = new BufferedReader(is);
            String line;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
            is = new InputStreamReader(process.getErrorStream(), Charset.forName("GBK"));
            br = new BufferedReader(is);
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //关闭连接
            if (process != null && process.isAlive()) {
                process.destroy();
            }
        }
    }

    public static void main2(String[] args) {
        try {
            List<String> list = new ArrayList<String>();
            //启动 windows 的计算器程序，第一个参数必须是可执行程序
//            paramList.add("C:\\Windows\\System32\\calc.exe");
            String[] cmd = {"C:/Windows/system32/cmd.exe", "/c", "dir"};
            String[] cmd1 = {"C:/Java/PortableGit/bin/bash.exe", "-c", "git"};

            list.add("cmd");
            list.add("/c");
            list.add("start");
            list.add("\"" + "cmd.exe" + "\"");
            list.add("\"" + "C:/Windows/system32/cmd.exe" + "\"");
//            list.add("\"" + "Bootstrapper.exe" + "\"");
//            list.add("\"" + "C:/Program Files (x86)/Enterprise Vault/Bootstrapper.exe" + "\"");
            list.add(" & ");
            list.add("dir");

            /** 创建ProcessBuilder对象，设置指令列表*/
            ProcessBuilder processBuilder = new ProcessBuilder(cmd1);
            processBuilder.redirectErrorStream(true);
            Process process = processBuilder.start();

            InputStream in = process.getInputStream();
            byte[] re = new byte[1024];
            while (in.read(re) != -1) {
                System.out.println("==>" + new String(re, Charset.forName("GBK")));
            }
            in.close();
            if (process.isAlive()) {
                process.waitFor();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main3(String[] args) {
        try {
            Desktop desktop = Desktop.getDesktop();
            File file = new File("C:/Windows/system32/cmd.exe");
            desktop.open(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

####参考文章：
https://juejin.im/entry/5ba46a576fb9a05d3b336b43
https://blog.walterlv.com/post/cmd-startup-arguments.html
