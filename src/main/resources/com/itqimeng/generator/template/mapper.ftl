<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${prop.mapperPackageName}.${table.tableName}" >
  <resultMap id="BaseResultMap" type="${prop.entityPackageName}.${table.tableName}" >
	<#-- 主键字段-->
	<#list  table.primaryKeyColumns as column>
	<id column="${column.actualColumnName}" property="${column.columnNameLower}" jdbcType="${column.jdbcTypeInformation.jdbcTypeName}" /> 
	</#list>
    <#--非主键列，非blob列-->
	<#list  table.baseColumns as column>
	<result column="${column.actualColumnName}" property="${column.columnNameLower}" jdbcType="${column.jdbcTypeInformation.jdbcTypeName}" /> 
	</#list>
  </resultMap>
  <sql id="Base_Column_List" >
    <#-- 字段 -->
	<#list  table.allColumns as column>
	A.${column.actualColumnName}<#if column_has_next>,</#if>
	</#list>
  </sql>
  <select id="getEntityByPKId" parameterType="java.lang.String" resultMap="BaseResultMap">
    select 
    <include refid="Base_Column_List" />
    from ${table.actualTableName} A 
    where 1=1
    <#-- 主键字段-->
	<#list  table.primaryKeyColumns as column>
	and A.${column.actualColumnName}<#noparse>=#{pkId,jdbcType=VARCHAR}</#noparse>
	</#list>
  </select>
  <insert id="addEntity" parameterType="${prop.entityPackageName}.${table.tableName}">
	   insert into ${table.actualTableName}(
	   <#-- 字段 -->
	   <#list  table.allColumns as column>${column.actualColumnName}<#if column_has_next>,</#if></#list>
	   )values(
	   <#-- 字段 -->
	   <#list  table.allColumns as column><#noparse>#{</#noparse>${column.columnNameLower}<#noparse>}</#noparse><#if column_has_next>,</#if></#list>
		)
  </insert>
</mapper>