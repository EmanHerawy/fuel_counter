contract;

storage {
    counter: u64=0,
    // owner:Address=0x0,

}
abi MyContract {
     #[storage(read)]
    fn count()->u64;
    #[storage(read,write)]
    fn increment();
}

impl MyContract for Contract {
       #[storage(read)]
    fn count()->u64{
        storage.counter.read()
    }
    #[storage(read,write)]
    fn increment(){
        require(storage.counter.read()<3,"counter must be less than 3");
        storage.counter.write(storage.counter.read()+1);
    }
}

#[test]
 fn test_count(){
let caller = abi(MyContract, CONTRACT_ID);
assert_eq(caller.count(),0);  
caller.increment();
assert_eq(caller.count(),1); 
caller.increment();



 }

#[test(should_revert)]
 fn test_count_should_revert(){
let caller = abi(MyContract, CONTRACT_ID);
caller.increment();
caller.increment();
caller.increment();
caller.increment();



 }

