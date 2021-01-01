#[macro_use]
extern crate juniper;
use juniper::{EmptyMutation, FieldResult, InputValue};

#[derive(Debug, Clone)]
struct User {
  id: String,
  name: String,
  friend_ids: Vec<String>,
}

struct Ctx {
  pub users_vec: Vec<User>,
}

impl juniper::Context for Ctx {}

graphql_object!(User: Ctx |&self| {
  field id() -> &str { self.id.as_str() }
  field name() -> &str { self.name.as_str() }

  field friends(&executor) -> Vec<&User> {
    let mut _friends: Vec<&User> = Vec::new();
    let ctx = executor.context();
    for id in self.friend_ids.iter() {
      if let Some(user) = ctx.users_vec.iter().find(|u| u.id == *id) {
        _friends.push(user)
      }
    }
    _friends
  }
});

struct Query;

graphql_object!(Query: Ctx |&self| {
  field user(&executor, id: String) -> FieldResult<&User> {
    let ctx = executor.context();
    match ctx.users_vec.iter().find(|u| u.id == id) {
      Some(user) => Ok(user),
      None => Err("User not found!")?,
    }
  }
});

type Schema = juniper::RootNode<'static, Query, EmptyMutation<Ctx>>;

fn main() {
  // Create a context object.
  let mut ctx = Ctx {
    users_vec: Vec::new(),
  };
  init_context(&mut ctx);
  let schema = Schema::new(Query, EmptyMutation::new());

  // Run the executor.
  let (res, _errors) = juniper::execute(
    "query user($id: String!){
      user(id: $id){
        id,
        name
        friends {
          name
        }
      }
    }",
    None,
    &schema,
    // /&juniper::Variables::new(),
    &vec![("id".to_owned(), InputValue::scalar("xyz"))]
      .into_iter()
      .collect(),
    &ctx,
  )
  .unwrap();

  println!("{:?}", ctx.users_vec);
  println!("Number of errors: {}", _errors.len());
  println!("Errors: {:?}", _errors);
  // Ensure the value matches.

  let data = res.as_object_value().unwrap();
  println!("{:?}", data);
}

fn init_context(ctx: &mut Ctx) {
  ctx.users_vec.push(User {
    id: String::from("abc"),
    name: String::from("Ferris Rust"),
    friend_ids: vec![String::from("xyz")],
  });
  ctx.users_vec.push(User {
    id: String::from("mnp"),
    name: String::from("Dash Dart"),
    friend_ids: vec![String::from("xyz")],
  });
  ctx.users_vec.push(User {
    id: String::from("xyz"),
    name: String::from("Tux Linux"),
    friend_ids: vec![String::from("abc"), String::from("mnp")],
  });
}
