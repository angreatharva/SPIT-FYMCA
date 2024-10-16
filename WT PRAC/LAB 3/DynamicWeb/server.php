<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

// initializing variables
$username = "";
$email    = "";
$errors = array(); 

// connect to the database
$db = mysqli_connect('localhost', 'root', '', 'shoe_web');

// REGISTER USER
if (isset($_POST['reg_user'])) {
  // receive all input values from the form
  $username = mysqli_real_escape_string($db, $_POST['username']);
  $email = mysqli_real_escape_string($db, $_POST['email']);
  $password_1 = mysqli_real_escape_string($db, $_POST['password_1']);
  $password_2 = mysqli_real_escape_string($db, $_POST['password_2']);

  // form validation: ensure that the form is correctly filled ...
  // by adding (array_push()) corresponding error unto $errors array
  if (empty($username)) { array_push($errors, "Username is required"); }
  if (empty($email)) { array_push($errors, "Email is required"); }
  if (empty($password_1)) { array_push($errors, "Password is required"); }
  if ($password_1 != $password_2) {
	array_push($errors, "The two passwords do not match");
  }

  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = "SELECT * FROM users WHERE username='$username' OR email='$email' LIMIT 1";
  $result = mysqli_query($db, $user_check_query);
  $user = mysqli_fetch_assoc($result);
  
  if ($user) { // if user exists
    if ($user['username'] === $username) {
      array_push($errors, "Username already exists");
    }

    if ($user['email'] === $email) {
      array_push($errors, "email already exists");
    }
  }

  // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {
  	$password = md5($password_1);//encrypt the password before saving in the database

  	$query = "INSERT INTO users (username, email, password) 
  			  VALUES('$username', '$email', '$password')";
  	mysqli_query($db, $query);
  	$_SESSION['username'] = $username;
  	$_SESSION['success'] = "You are now logged in";
  	header('location: Nike.html');
  }
}

// LOGIN USER
if (isset($_POST['login_user'])) {
  $username = mysqli_real_escape_string($db, $_POST['username']);
  $password = mysqli_real_escape_string($db, $_POST['password']);

  if (empty($username)) {
  	array_push($errors, "Username is required");
  }
  if (empty($password)) {
  	array_push($errors, "Password is required");
  }

  if (count($errors) == 0) {
  	$password = md5($password);
  	$query = "SELECT * FROM users WHERE username='$username' AND password='$password'";
  	$results = mysqli_query($db, $query);
  	if (mysqli_num_rows($results) == 1) {
  	  $_SESSION['username'] = $username;
  	  $_SESSION['success'] = "You are now logged in";
  	  header('location: Nike.html');
  	}else {
  		array_push($errors, "Wrong username/password combination");
  	}
  }
}

// Fetch user session data
if (isset($_GET['fetch_user_data'])) {
  if (isset($_SESSION['username'])) {
      // Assuming you want to fetch the user ID as well
      $username = $_SESSION['username'];
      $query = "SELECT id FROM users WHERE username='$username' LIMIT 1";
      $result = mysqli_query($db, $query);
      $user = mysqli_fetch_assoc($result);
      
      if ($user) {
          echo json_encode(array('username' => $username, 'id' => $user['id']));
      } else {
          echo json_encode(array('error' => 'User not found'));
      }
  } else {
      echo json_encode(array('error' => 'No active session'));
  }
  exit();
}


// Fetch Products
if (isset($_GET['fetch_products'])) {
  $query = "SELECT * FROM products";
  $result = mysqli_query($db, $query);
  
  $products = array();
  
  while ($row = mysqli_fetch_assoc($result)) {
      $products[] = $row;
  }
  
  echo json_encode($products);
  exit(); // Stop further execution
}



// Fetch single product by ID
if (isset($_GET['fetch_product_details'])) {
    $product_id = intval($_GET['id']); // Sanitize the ID input

    // Check if product ID is valid
    if ($product_id > 0) {

        // Prepare the SQL query to fetch the specific product
        $query = "SELECT * FROM products WHERE id = ?";
        $stmt = mysqli_prepare($db, $query);
        
        if ($stmt) {
            mysqli_stmt_bind_param($stmt, 'i', $product_id); // Bind the product ID as an integer
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);

            // Check if the product exists
            if ($row = mysqli_fetch_assoc($result)) {
                echo json_encode($row); // Return the product details as JSON
            } else {
                echo json_encode(array('error' => 'Product not found'));
            }

            // Close the prepared statement
            mysqli_stmt_close($stmt);
        } else {
            echo json_encode(array('error' => 'Failed to prepare query'));
        }
    } else {
        echo json_encode(array('error' => 'Invalid product ID'));
    }
    
    exit(); // Stop further execution
}


?>