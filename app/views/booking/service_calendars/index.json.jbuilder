json.array!(@service_type_reservations) do |servRes|
	json.title servRes.service_type.name
	json.reservation servRes.reservation
	json.id servRes.reservation.id
	json.start servRes.reservation.check_in 
	json.end servRes.reservation.check_out
	json.url customer_url(servRes.reservation.customer, format: :html)
	json.customer_title servRes.reservation.customer.title
	json.customer_first_name servRes.reservation.customer.first_name
	json.customer_last_name servRes.reservation.customer.last_name
	json.customer_phone servRes.reservation.customer.phone
	json.customer_id servRes.reservation.customer.id
end
