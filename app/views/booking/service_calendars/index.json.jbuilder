json.array!(@service_type_reservations) do |servRes|
	json.title servRes.service_type.name
	json.reservation servRes.reservation
	json.id servRes.reservation.id
	json.start servRes.check_in
	json.end servRes.check_out
	#json.url reservations_url(servRes.reservation.id, format: :html)
	json.customer_id servRes.reservation.customer_id
	json.customer_title @customers.find(servRes.reservation.customer_id).title
	json.customer_first_name @customers.find(servRes.reservation.customer_id).first_name
	json.customer_last_name @customers.find(servRes.reservation.customer_id).last_name
	json.customer_phone @customers.find(servRes.reservation.customer_id).phone
	json.customer_email @customers.find(servRes.reservation.customer_id).email
end
