/* facts */
pharmacy('001', 'Chain Pharmacy A', '123 Main St.', '555-1234').
pharmacy('002', 'Chain Pharmacy B', '456 Oak Ave.', '555-5678').
pharmacy('003', 'Chain Pharmacy C', '789 Elm St.', '555-9012').

medication('111111', 'Aspirin').
medication('222222', 'Ibuprofen').
medication('333333', 'Acetaminophen').

sales('001', '111111', 5.00, 100).
sales('001', '222222', 7.50, 50).
sales('001', '333333', 10.00, 25).
sales('002', '111111', 4.50, 200).
sales('002', '222222', 8.00, 75).
sales('002', '333333', 12.00, 40).
sales('003', '111111', 6.00, 150).
sales('003', '222222', 10.00, 60).
sales('003', '333333', 15.00, 30).

/* rules */
available_at(Medication, Pharmacy, Price, Quantity) :- medication(MedID, Medication), pharmacy(PharmID, _, _, _), sales(PharmID, MedID, Price, Quantity).
cheapest_pharmacy(Medication, Quantity, Pharmacy, Address) :- available_at(Medication, Pharmacy, Price, Quantity), not((available_at(Medication, _, OtherPrice, _), OtherPrice < Price)), pharmacy(Pharmacy, ChainName, Address, _), ChainName = 'Chain Pharmacy A'.

/* queries */
?- cheapest_pharmacy('Aspirin', 100, Pharmacy, Address).  % Pharmacy = '001', Address = '123 Main St.'
?- available_at('Ibuprofen', '002', Price, Quantity).  % Price = 8.00, Quantity = 75

