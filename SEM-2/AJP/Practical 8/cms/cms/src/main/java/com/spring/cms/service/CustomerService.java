package com.spring.cms.service;

import com.spring.cms.dao.CustomerDAO;
import com.spring.cms.exception.CustomerNotFoundException;
import com.spring.cms.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
public class CustomerService {

    @Autowired
    private CustomerDAO customerDAO;
//
    private List<Customer> customerList = new CopyOnWriteArrayList<>();
//    private int customerIdCount = 1;

    public  Customer addCutomer(Customer customer){
//        customer.setCustomerId(customerIdCount);
//        customerList.add(customer);
//        customerIdCount++;
//        return customer;
        return  customerDAO.save(customer);
    }

    public List<Customer> getCustomers(){
//        return customerList;
        return  customerDAO.findAll();
    }

    public Customer getCustomer(int customerId){
//        return customerList.stream().filter(c -> c.getCustomerId() == customerId).findFirst().get();

        Optional<Customer> optionalCustomer = customerDAO.findById(customerId);
        if(optionalCustomer.isEmpty()){
            throw new CustomerNotFoundException("Customer Record not available");
        }

        return optionalCustomer.get();
    }

     public Customer updateCustomer(int customerId,Customer customer){
//        customerList.stream().forEach(c -> {
//            if(c.getCustomerId() == customerId){
//                c.setCustomerFirstName(customer.getCustomerFirstName());
//                c.setCustomerLastName(customer.getCustomerLastName());
//                c.setCustomerEmail(customer.getCustomerEmail());
//            }
//        });
//        return customerList.stream().filter(c -> c.getCustomerId() == customerId).findFirst().get();

         customer.setCustomerId(customerId);
         return customerDAO.save(customer);
    }

     public void deleteCustomer(int customerId){
//        customerList.stream().forEach(c -> {
//            if(c.getCustomerId() == customerId){
//                customerList.remove(c);
//            }
//        });
         customerDAO.deleteById(customerId);
     }
}
