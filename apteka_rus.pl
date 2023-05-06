/* факты */
pharmacy('001', 'Сетевая аптека А', 'ул. Главная 123', '555-1234').
pharmacy('002', 'Сетевая аптека Б', 'ул. Дубовая 456', '555-5678').
pharmacy('003', 'Сетевая аптека В', 'ул. Вязовая 789', '555-9012').

medication('111111', 'Аспирин').
medication('222222', 'Ибупрофен').
medication('333333', 'Ацетаминофен').

sales('001', '111111', 5.00, 100).
sales('001', '222222', 7.50, 50).
sales('001', '333333', 10.00, 25).
sales('002', '111111', 4.50, 200).
sales('002', '222222', 8.00, 75).
sales('002', '333333', 12.00, 40).
sales('003', '111111', 6.00, 150).
sales('003', '222222', 10.00, 60).
sales('003', '333333', 15.00, 30).

/* правила */
available_at(Medication, Pharmacy, Price, Quantity) :- medication(MedID, Medication), pharmacy(PharmID, _, _, _), sales(PharmID, MedID, Price, Quantity).
cheapest_pharmacy(Medication, Quantity, Pharmacy, Address) :- available_at(Medication, Pharmacy, Price, Quantity), not((available_at(Medication, _, OtherPrice, _), OtherPrice < Price)), pharmacy(Pharmacy, ChainName, Address, _), ChainName = 'Сетевая аптека А'.

/* запросы */
?- cheapest_pharmacy('Аспирин', 100, Pharmacy, Address).  % Pharmacy = '001', Address = 'ул. Главная 123'
?- available_at('Ибупрофен', '002', Price, Quantity).  % Price = 8.00, Quantity = 75
