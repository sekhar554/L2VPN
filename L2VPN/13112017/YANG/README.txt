You can extra the extract the bharti.zip folder and follow the folling steps to bring up the testing environment.

1. make clean all
2. make update-nexus
3. make setup-test-env

Whereas we strongly recommend that replace the following files and proceed with L2 Testing

1. Replace the make file at $NCS-RUN/Bharti
2. Replace the make file at $NCS-RUN/Bharti/test
3. Replace the make file at $NCS-RUN/Bharti/test/run
4. Copy the config.sh file to $NCS-RUN/Bharti/test/run
5. Copy the mpls-l2vpn lux folder to $NCS-RUN/Bharti/test/lux
6. Copy the mpls-l2vpn package folder to $NCS-RUN/Bharti/packages

Than follow the following steps

1. make clean all
2. make update-nexus
3. make setup-test-env

It will create the required topology with basic configuration for all the scenarios , please make 
sure you have proper setup before starting TCs


Note : We have covered all the scenarios 6.1 to 6.9 TCs both for service provisioning and re-conciliation .

Further builds based on bugs and any new enhancement .

Version 1: Addressed the yang changes as per customer request.
     A) Removed media-type, link-log, speed, negotiation, keep alive, load-interval, arp-     inspect, l2protocol from override container to provision container 

Version 2: 
   1. Addition of a service container for much more specific description formats – this will only be used for descriptions.
   2. Removal of the Auto No Neg container and making it a type empty.
 
Auto No neg:
 
  container no-autoneg {
        description "Disable interface auto negotiation";
        tailf:info "Disable interface auto negotiation";
        presence "If no auto negotiation";
        
        leaf speed {
          description "Interface speed";
          tailf:info "Interface speed";
          mandatory true;
          type enumeration {
            enum 10;
            enum 100;
            enum 1000;
            enum 10000;
           }
          }
  
         leaf full-duplex {
           description "Interface Duplex";
           tailf:info "Interface Duplex";
           type empty;
          }
        }
 
… will now become one type empty for choosing to turn on or off auto negotiation. We will remove speed and full duplex leaves and turn the whole container into one type empty.
 
Service Container:
    container service {
      choice name {
        container business {
          leaf type {
            type union {
              type enumeration {
                enum isp;
                enum ilp;
                enum mpls;
                enum e2ecen;
                enum backhaul;
                enum ang;
                enum tng;
                enum expressway;
              }
              type string {
                pattern "^\S{2,20}$" {
                  error-message "Invalid name";
                }
              }
            }
          }
        }
        container mobility {
          leaf type {
            type string {
              pattern "^\S{2,20}$" {
                error-message "Invalid name";
              }
            }
          }
        }
        container dslam {
          leaf type {
            type union {
              type enumeration {
                enum main_port;
                enum mgmt;
                enum wifi;
                enum static;
                enum dynamic;
                enum media;
                enum signalling;
                enum ims;
              }
              type string {
                pattern "^\S{2,20}$" {
                  error-message "Invalid name";
                }
              }
            }
          }
        }
      }
    }


