- 选择器



## HTML 选择器(JS)

1. id选择器

   ```
   document.getElementById("idname")
   ```

2. 标签选择器

   ```
   //直接跟元素的名称
   document.getElementsByTagName("p|button|div");
   ```

3. 类选择器

   ```
   //指定类名的元素集合
   document.getElementsByClassName("classname")
   //例如
   var class_name=document.getElementsByClassName("classname")
   class_name[0].onclick
   ```

4. 通用选择器

   ```
   //id\class\tab 都可以
   document.querySelector("id|class|tab")
   document.querySelectorAll("id|class|tab")
   ```

   

## CSS选择器

1. id选择器 : 使用#

   ```
   <style>#useid{...}</style>
   ```

2. 类选择器：使用.

   ```
   <style>.useid{...}</style>
   ```

3. 标签选择器

   ```
   <style>body{...}</style>
   ```



## Jquery选择器(基于css选择器)

1. id选择器 : 使用#

   ```
   <script>$("#useid").click(function(){...})</script>
   ```

2. 类选择器：使用.

   ```
   <script>$(".useid").click(function(){...})</script>
   ```

3. 元素选择器（等于标签选择器）

   ```
   <script>$("p|button|div").click(function(){...})</script> 
   ```

