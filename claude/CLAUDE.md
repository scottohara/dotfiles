# Coding styles

## Frontend development

Frontend development refers to projects that:

- Use a frontend framework (Svelte, Angular.js)
- Use Typescript or Javascript intended to run in browsers

### Testing

For projects that use vitest or mocha (`describe`, `it`, `beforeEach`, `afterEach`), prefer concise arrow function bodies for `it`, `beforeEach` and `afterEach` blocks that only have a single `expect` assertion, e.g.

```ts
decribe("bad style", (): void => {
  beforeEach((): void => {
    setup();
  });

  afterEach((): void => {
    teardown();
  });

  it("should not throw", (): void => {
    expect({}).not.toThrow();
  });
});

decribe("good style", (): void => {
  beforeEach((): void => setup());

  afterEach((): void => teardown());

  it("should not throw", (): void => expect({}).not.toThrow());
});
```
