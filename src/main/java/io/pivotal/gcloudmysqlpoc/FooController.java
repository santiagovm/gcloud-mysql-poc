package io.pivotal.gcloudmysqlpoc;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
public class FooController {

    private final FooRepository _fooRepo;

    public FooController(FooRepository fooRepo) {
        _fooRepo = fooRepo;
    }

    @GetMapping("/")
    List<Foo> getFoo() {
        CreateFooRecords();
        return GetFooRecords();
    }

    private List<Foo> GetFooRecords() {
        return _fooRepo.getFoo();
    }

    private void CreateFooRecords() {
        Foo foo1 = new Foo();
        Foo foo2 = new Foo();

        foo1.setName("foo-" + UUID.randomUUID());
        foo2.setName("foo-" + UUID.randomUUID());

        _fooRepo.save(foo1);
        _fooRepo.save(foo2);
    }
}
