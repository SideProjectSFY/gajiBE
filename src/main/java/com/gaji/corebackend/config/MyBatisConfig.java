package com.gaji.corebackend.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;
import java.util.UUID;

/**
 * MyBatis Configuration
 * Registers custom TypeHandlers for PostgreSQL UUID handling
 */
@Configuration
public class MyBatisConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        
        // Set mapper locations
        sessionFactory.setMapperLocations(
            new PathMatchingResourcePatternResolver().getResources("classpath:mapper/**/*.xml")
        );
        
        // Create MyBatis Configuration
        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
        
        // Set type aliases package
        sessionFactory.setTypeAliasesPackage("com.gaji.corebackend.entity");
        configuration.setMapUnderscoreToCamelCase(true);
        configuration.setCacheEnabled(true);
        configuration.setLazyLoadingEnabled(false);
        configuration.setAggressiveLazyLoading(false);
        
        // Register UUID type handler BEFORE building SqlSessionFactory
        TypeHandlerRegistry typeHandlerRegistry = configuration.getTypeHandlerRegistry();
        typeHandlerRegistry.register(UUID.class, JdbcType.OTHER, new org.apache.ibatis.type.BaseTypeHandler<UUID>() {
            @Override
            public void setNonNullParameter(java.sql.PreparedStatement ps, int i, UUID parameter, JdbcType jdbcType) throws java.sql.SQLException {
                ps.setObject(i, parameter);
            }

            @Override
            public UUID getNullableResult(java.sql.ResultSet rs, String columnName) throws java.sql.SQLException {
                Object value = rs.getObject(columnName);
                return value == null ? null : (UUID) value;
            }

            @Override
            public UUID getNullableResult(java.sql.ResultSet rs, int columnIndex) throws java.sql.SQLException {
                Object value = rs.getObject(columnIndex);
                return value == null ? null : (UUID) value;
            }

            @Override
            public UUID getNullableResult(java.sql.CallableStatement cs, int columnIndex) throws java.sql.SQLException {
                Object value = cs.getObject(columnIndex);
                return value == null ? null : (UUID) value;
            }
        });
        
        // Set configuration to sessionFactory
        sessionFactory.setConfiguration(configuration);
        
        return sessionFactory.getObject();
    }
}
