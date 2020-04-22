package io.pivotal.gcloudmysqlpoc;

import java.util.List;

public interface FooRepository {
    void save(Foo foo);
    List<Foo> getFoo();
}
