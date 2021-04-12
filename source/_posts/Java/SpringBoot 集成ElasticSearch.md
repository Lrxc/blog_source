---
title: Springboot 集成ElasticSearch
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


## 环境

- springboot：2.1.6.RELEASE
- elasticsearch: 6.5.3



## 简介

目前 Elasticsearch 有很多第三方 Java 客户端如 TransportClient，Jest, Spring Data Elasticsearch（Spring Data 对 Elasticsearch 的整合）,还有官方的Java REST Client，而Java REST Client 有两种版本:

1. Java Low Level REST Client
2. Java High Level REST Client

Java high-level REST client 是目前官方推荐使用的客户端



## 一 Springboot Data集成

1. pom文件

   ```java
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-web</artifactId>
   </dependency>
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-test</artifactId>
   </dependency>
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-data-elasticsearch</artifactId>
   </dependency>
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <scope>provided</scope>
   </dependency>
   <!--工具类-->    
   <dependency>
       <groupId>cn.hutool</groupId>
       <artifactId>hutool-all</artifactId>
       <version>5.5.0</version>
   </dependency>
   ```

2. application配置文件

   ```yml
   server:
     port: 8080
   spring:
     data:
       elasticsearch:
         cluster-nodes: 192.168.109.134:9300   #代码是9300端口
         cluster-name: my-application          #和./config/elasticsearch.yml的cluster-name名字相同
   ```

3. 实体类

   @Document 注解主要声明索引名、类型名

   @Field 注解主要声明字段对应ES的类型

   ```java
   @Document(indexName = "person", type = "person")
   @Data
   @AllArgsConstructor
   public class Person {
   
       //id字段是必须的，可以不写注解@Id
       @Id
       private Long id;
   
       @Field(type = FieldType.Keyword)
       private String name;
   
       @Field(type = FieldType.Integer)
       private Integer age;
   }
   ```

4. repostory

   ```java
   public interface PersonRepository extends ElasticsearchRepository<Person, Long> {
   }
   ```

5. 测试

   ```java
   @Slf4j
   @RunWith(SpringRunner.class)
   @SpringBootTest
   public class PersonRepositoryTest {
       @Autowired
       private PersonRepository repo;
   
       /**
        * 测试新增
        */
       @Test
       public void save() {
           Person person = new Person(1L, "刘备", 18);
           Person save = repo.save(person);
           log.info("【save】= {}", save);
       }
   
       /**
        * 测试批量新增
        */
       @Test
       public void saveList() {
           List<Person> personList = Lists.newArrayList();
           personList.add(new Person(2L, "曹操", 20));
           personList.add(new Person(3L, "孙权", 19));
           personList.add(new Person(4L, "诸葛亮", 16));
           Iterable<Person> people = repo.saveAll(personList);
           log.info("【people】= {}", people);
       }
   
       /**
        * 测试更新
        */
       @Test
       public void update() {
           repo.findById(1L).ifPresent(person -> {
               person.setName(person.getName() + "\n更新更新更新更新更新");
               Person save = repo.save(person);
               log.info("【save】= {}", save);
           });
       }
   
       /**
        * 测试删除
        */
       @Test
       public void delete() {
           // 主键删除
           repo.deleteById(1L);
   
           // 对象删除
           repo.findById(2L).ifPresent(person -> repo.delete(person));
   
           // 批量删除
           repo.deleteAll(repo.findAll());
       }
   
       /**
        * 测试普通查询，按年龄倒序
        */
       @Test
       public void select() {
           repo.findAll(Sort.by(Sort.Direction.DESC, "age"))
                   .forEach(person -> log.info("{} 生日: {}", person.getName(), person.getAge()));
       }
   
       /**
        * 自定义查询，根据年龄范围查询
        */
       @Test
       public void customSelectRangeOfAge() {
           repo.findByAgeBetween(18, 19).forEach(person -> log.info("{} 年龄: {}", person.getName(), person.getAge()));
       }
   }
   ```



## 二 Springboot集成Java high-level REST client

1. pom 文件

      必须的依赖

      ```java
      <properties>
          <elasticsearch>7.3.0</elasticsearch>
      </properties>
      <dependencies>
          <!-- elasticsearch -->
          <dependency>
              <groupId>org.elasticsearch</groupId>
              <artifactId>elasticsearch</artifactId>
              <version>${elasticsearch}</version>
          </dependency>
          <!-- elasticsearch-rest-client -->
          <dependency>
              <groupId>org.elasticsearch.client</groupId>
              <artifactId>elasticsearch-rest-client</artifactId>
              <version>${elasticsearch}</version>
          </dependency>
          <!-- elasticsearch-rest-high-level-client -->
          <dependency>
              <groupId>org.elasticsearch.client</groupId>
              <artifactId>elasticsearch-rest-high-level-client</artifactId>
              <version>${elasticsearch}</version>
              <exclusions>
                  <exclusion>
                      <groupId>org.elasticsearch.client</groupId>
                      <artifactId>elasticsearch-rest-client</artifactId>
                  </exclusion>
                  <exclusion>
                      <groupId>org.elasticsearch</groupId>
                      <artifactId>elasticsearch</artifactId>
                  </exclusion>
              </exclusions>
          </dependency>
          <!--工具类-->
          <dependency>
              <groupId>cn.hutool</groupId>
              <artifactId>hutool-all</artifactId>
              <version>5.5.0</version>
          </dependency>
      </dependencies>
      ```

      

2. application 配置文件

      ```yml
      server:
        port: 8080
      demo:
        data:
          elasticsearch:
            cluster-nodes: 192.168.109.134:9200   #这个是9200端口
            cluster-name: my-application          #和/config/elasticsearch.yml的cluster-name名字相同
      ```

3. 具体代码实现： https://github.com/Lrxc/spring-boot-demo/tree/master/demo-elasticsearch-rest-high-level-client



## 常见错误

1. elasticsearch Validation Failed: 1: type is missing;

   ES服务器版本过低，升级到7.x以上

## 参考：

https://zhuanlan.zhihu.com/p/42763550