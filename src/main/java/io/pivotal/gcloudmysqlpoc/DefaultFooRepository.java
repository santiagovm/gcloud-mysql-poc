package io.pivotal.gcloudmysqlpoc;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DefaultFooRepository implements FooRepository {

    private final JdbcTemplate _jdbcTemplate;

    public DefaultFooRepository(JdbcTemplate jdbcTemplate) {
        _jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void save(Foo foo) {
        String insertQuery = "insert foo (name) values (?)";
        _jdbcTemplate.update(insertQuery, foo.getName());
    }

    @Override
    public List<Foo> getFoo() {
        String selectQuery = "select id, name from foo";

        RowMapper<Foo> rowMapper = (rs, rowNum) -> {
            Foo foo = new Foo();
            foo.setId(rs.getInt("id"));
            foo.setName(rs.getString("name"));
            return foo;
        };

        return _jdbcTemplate.query(selectQuery, rowMapper);
    }
}
