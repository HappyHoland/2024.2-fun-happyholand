import Fun.Nat
import Fun.List

theorem zero_add (n: nat): add .O n = n := by
    induction n

    case O =>
        rw [add] -- add.1 n := O

    case S d hd =>
        rw [add] -- add.2 n := O, m := d
        rw [hd]

theorem succ_add (n m: nat): add (.S n) m = .S (add n m) := by
    induction m

    case O =>
        rw [add] -- add.1 n := n.S
        rw [add] -- add.1 n := n

    case S d hd =>
        rw [add] -- add.2 n := n.S, m := d
        rw [hd]
        rw [add] -- add.2 n := n, m := d

theorem succ_eq_add_one (n: nat): n.S = add n (.S (.O)) := by
    rw [add] -- add.2 n := n, m := nat.O.S
    rw [add] -- add.1 n := n

theorem add_comm (n m: nat): add n m = add m n := by
    induction m

    case O =>
        rw [add] -- add.1 n := n
        rw [zero_add n]

    case S d hd =>
        rw [add] -- add.2 n := n, m := d
        rw [succ_add d n]
        rw [hd]

theorem add_ass (n m k: nat): add n (add m k) = add (add n m) k := by
    induction k

    case O =>
        rw [add] -- add.1 n := m
        rw [add] -- add.1 n := add n m

    case S d hd =>
        rw [add] -- add.2 n := m, m := d
        rw [add] -- add.2 n := n, m := add m d
        rw [add] -- add.2 n := add n m, m := d
        rw [hd]

theorem zero_mul (n: nat): mul .O n = .O := by
    induction n

    case O =>
        rw [mul] -- mul.1 n := O

    case S d hd =>
        rw [mul] -- mul.2 n := O, m := d
        rw [hd]
        rw [add] -- add.1 n := O

theorem succ_mul (m n: nat): mul m.S n = add n (mul m n) := by
    induction n

    case O =>
        rw [mul] -- mul.1 n := S m
        rw [mul] -- mul.1 n := m
        rw [add] -- add.1 n := O

    case S d hd =>
        rw [succ_add d (mul m d.S)]
        rw [mul] -- mul.2 n := S m, m := d
        rw [mul] -- mul.2 n := m, m := d
        rw [succ_add m (mul m.S d)]
        rw [hd]
        rw [add_ass m d (mul m d)]
        rw [add_comm m d]
        rw [add_ass d m (mul m d)]

theorem mul_one (n: nat): mul n (.S (.O)) = n := by
    induction n

    case O =>
        rw [zero_mul nat.O.S]

    case S d hd =>
        rw [succ_mul d nat.O.S]
        rw [hd]
        rw [add_comm nat.O.S d]
        rw [← succ_eq_add_one d]

theorem one_mul (n: nat): mul (.S (.O)) n = n := by
    induction n

    case O =>
        rw [mul] -- add.1 n := S O

    case S d hd =>
        rw [mul] -- add.2 n := S O, m := d
        rw [hd]
        rw [add_comm nat.O.S d]
        rw [← succ_eq_add_one d]

theorem mul_comm (n m: nat): mul n m = mul m n := by
    induction m

    case O =>
        rw [mul] -- mul.1 n := n
        rw [zero_mul n]

    case S d hd =>
        rw [mul] -- mul.2 n := n, m := d
        rw [succ_mul d n]
        rw [hd]

theorem mul_add (n m k: nat): mul n (add m k) = add (mul n m) (mul n k) := by
    induction k

    case O =>
        rw [add] -- add.1 n := m
        rw [mul] -- mul.1 n := n
        rw [add] -- add.1 n := mul n m

    case S d hd =>
        rw [add] -- add.2 n := m, m := d
        rw [mul] -- mul.2 n := m, m := add m d
        rw [mul] -- mul.2 n := n, m := d
        rw [add_ass (mul n m) n (mul n d)]
        rw [add_comm (mul n m) n]
        rw [← add_ass n (mul n m) (mul n d)]
        rw [hd]

theorem mul_ass (n m k: nat): mul n (mul m k) = mul (mul n m) k := by
    induction k

    case O =>
        rw [mul] -- mul.1 n := m
        rw [mul] -- mul.1 n := n
        rw [mul] -- mul.1 n := (mul n m)

    case S d hd =>
        rw [mul] -- mul.2 n := m, m := d
        rw [mul] -- mul.2 n := (mul n m), m := d
        rw [mul_add]
        rw [hd]

theorem concat_nil (l: list a): concat l .nil = l := by
  induction l

  case nil =>
    rw [concat] -- concat.1 l := nil

  case cons x xs hd =>
    rw [concat] -- concat.2 l: cons x xs, l' := nil
    rw [hd]

theorem concat_ass (xs ys zs: list a): concat xs (concat ys zs) = concat (concat xs ys) zs := by
  induction xs

  case nil =>
    rw [concat] -- concat.1 l := concat ys zs
    rw [concat] -- concat.1 l := ys

  case cons x xs hd =>
    rw [concat] -- concat.2 l := x::xs, l' := concat ys zs
    rw [concat] -- concat.2 l := x::xs, l' := ys
    rw [concat] -- concat.2 l := x :: (concat xs ys), l' := zs
    rw [hd]

theorem rev_concat (xs ys: list a): reverse (concat xs ys) = concat (reverse ys) (reverse xs) := by
  induction xs

  case nil =>
    rw [concat] -- concat.1 l := ys
    rw [reverse] -- reverse.1
    rw [concat_nil (reverse ys)]

  case cons x xs hd =>
    rw [concat] -- concat.2 l := x::xs, l' := ys
    rw [reverse] -- reverse.2 l := x :: (xs ++ ys)
    rw [reverse] -- reverse.2 l := x::xs
    rw [hd]
    rw [concat_ass (reverse ys) (reverse xs) (.cons x .nil)]

theorem rev_rev (l: list a): reverse (reverse l) = l := by
  induction l

  case nil =>
    rw [reverse]
    rw [reverse]

  case cons x xs hd =>
    rw [reverse] -- reverse.2 l := cons x xs
    rw [rev_concat (reverse xs) (.cons x .nil)]
    rw [hd]
    rw [reverse] -- reverse.2 l := cons x nil
    rw [reverse] -- reverse.1
    rw [concat] -- concat.1 l := cons x nil
    rw [concat] -- concat.2 l := cons x nil, l' := xs
    rw [concat] -- concat.1 l := xs

theorem eq_list_imp_eq_cons (x: a) (l l': list a): l = l' → list.cons x l = list.cons x l' := by
  intro h
  rw [h]

theorem concat_take_drop_n (n: nat) (l: list a): concat (take n l) (drop n l) = l := by
  induction l

  case nil =>
    rw [take]
    rw [drop]
    rw [concat]

  case cons x xs hd =>
