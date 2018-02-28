# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias TaskTracker.{Repo, Accounts, Tasks}
alias Accounts.{User, Manager}
alias Tasks.{Task, TimeBlock}

# init users
tim = Repo.insert!(%User{name: "Tim"})
tina = Repo.insert!(%User{name: "Tina"})
jack = Repo.insert!(%User{name: "Jack"})
tom = Repo.insert!(%User{name: "Tom"})
glyn = Repo.insert!(%User{name: "Glyn"})
bill = Repo.insert!(%User{name: "Bill"})
alice = Repo.insert!(%User{name: "Alice"})

# init managers
m_tina = Repo.insert!(%Manager{user_id: tina.id})
m_glyn = Repo.insert!(%Manager{user_id: glyn.id})

# connect managers & users
Repo.update(tim |> User.changeset(%{manager_id: m_tina.id}))
Repo.update(bill |> User.changeset(%{manager_id: m_tina.id}))
Repo.update(jack |> User.changeset(%{manager_id: m_tina.id}))
Repo.update(tom |> User.changeset(%{manager_id: m_glyn.id}))
Repo.update(alice |> User.changeset(%{manager_id: m_glyn.id}))

# init tasks
task1 = %Task{user_id: tom.id, title: "Practice", desc: "In 1966, a dyslexic sixteen-year-old boy dropped out of school. With the help of a friend, he started a magazine for students and made money by selling advertisements to local businesses. With only a little bit of money to get started, he ran the operation out of the crypt inside a local church."}
task2 = %Task{user_id: tom.id, title: "Lunch", desc: "Scroll down to browse all of my articles by date and title. Articles are listed in reverse chronological order with my newest articles at the top and my oldest essays at the bottom"}
task3 = %Task{user_id: tom.id, title: "Dinner", desc: "Four years later, he was looking for ways to grow his small magazine and started selling mail order records to the students who bought the magazine. "}
task4 = %Task{user_id: bill.id, title: "Note", desc: "The records sold well enough that he built his first record store the next year. "}
task5 = %Task{user_id: jack.id, title: "Best Articles", desc: "He rented the recording studio out to local artists, including one named Mike Oldfield. In that small recording studio, Oldfield created his hit song, Tubular Bells, which became the record label’s first release. "}
task6 = %Task{user_id: glyn.id, title: "Date", desc: "Over the next decade, the young boy grew his record label by adding bands like the Sex Pistols, Culture Club, and the Rolling Stones. "}
task7 = %Task{user_id: glyn.id, title: "Place", desc: "an airline business, then trains, then mobile phones, and on and on. Almost 50 years later, there were over 400 companies under his direction."}
task8 = %Task{user_id: alice.id, title: "Winter", desc: "His name is Sir Richard Branson."}
task9 = %Task{user_id: alice.id, title: "Summer", desc: "His answers seemed unrehearsed and genuine."}
task10 = %Task{user_id: tim.id, title: "Cold", desc: "I was in my late twenties, so I had a business, but nobody knew who I was at the time. "}

t1 = Repo.insert! task1
t2 = Repo.insert! task2
t3 = Repo.insert! task3
t4 = Repo.insert! task4
t5 = Repo.insert! task5
t6 = Repo.insert! task6
t7 = Repo.insert! task7
t8 = Repo.insert! task8
t9 = Repo.insert! task9
t10 = Repo.insert! task10

# insert time time_blocks
t = NaiveDateTime.utc_now
tasks = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10]
tasks
|> Enum.map(fn t ->
  Enum.map(1..10, fn n ->
    s = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
    e = NaiveDateTime.add(s, 15*60) |> NaiveDateTime.truncate(:second)
    tb = Ecto.build_assoc(t, :time_blocks, %{start: s, end: e})
    Repo.insert!(tb |> TimeBlock.changeset(%{}))
    end
    )
  end)
