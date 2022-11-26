use common;

fn main() {
    println!("Start Game!");

    let mut left : i32 = 20;
    let mut right : i32 = 36;

    while right - left > 1 {
        let mid = left + (right - left) / 2;

        // Get input
        println!("Is the age less than {}? (yes / no)", mid);
        let mut ans = String::new();
        common::read_input_string(&mut ans);
        ans = ans.trim().to_string(); // remove the end of line

        match ans.as_str() {
            "yes" => right = mid,
            "no" => left = mid,
            _ => println!("Type the correct answer!"),
        }

    }
    println!("The age is {}!", left);

}