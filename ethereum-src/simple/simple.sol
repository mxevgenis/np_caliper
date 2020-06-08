pragma solidity >=0.4.22 <0.6.0;

contract simple {

  struct NetworkProvider{
      string name;                    // The name of the NP
      uint offered_resources;         // The amount of resources the NP offers to the network
      uint reserved_resources;        // The amount of resources the NP has for his own needs
      uint cost;                      // The cost of resources
      string domain;                  // The domain where these resources can be deployed
      uint sla;                       // A number that corresponds to certain SLA profiles

    }

    NetworkProvider[] public NetworkProviders;

    mapping (uint => address payable) public NetProvtoOwner;

    mapping (address => uint) OwnertoNetProv;

    mapping (address => bool) HasNetProv;


    mapping(string => int) private accounts;


    function open(string memory acc_id, int amount) public {
        accounts[acc_id] = amount;
    }

    function addNetworkProvider(string memory name, uint  offered_resources, uint reserved_resources, uint  cost, string memory domain, uint  sla, address payable _address) public{
        uint id= NetworkProviders.push(NetworkProvider(name,offered_resources,reserved_resources,cost,domain,sla)) - 1 ;
        NetProvtoOwner[id] =_address;
        OwnertoNetProv[_address] = id;
        HasNetProv[_address] = true;
        //np_count +=1;
    }

    function query(string memory acc_id) public view returns (int amount) {
        amount = accounts[acc_id];
    }



    function transfer(string memory acc_from, string memory acc_to, int amount) public {
        accounts[acc_from] -= amount;
        accounts[acc_to] += amount;
    }
}
