package MAIN.TRANSACTION.USER;

import java.util.ArrayList;

import MAIN.TRANSACTION.Transaction;

public class Consumer extends User {
	
	ArrayList<Transaction> transactionList;
	
    public Consumer(String name, String id, String password, String contact, int occupation, String preferredArea, Boolean pushAgreement, double averageScore, String userState, int transCnt) {
        super(name, id, password, contact, occupation, preferredArea, pushAgreement, averageScore, userState, transCnt);
    }

    public Consumer(User user) {
        super(user);
    }
    
}
