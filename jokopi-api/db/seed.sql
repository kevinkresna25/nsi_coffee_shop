-- roles
INSERT INTO roles (id, name) VALUES
(1, 'Admin'),
(2, 'User')
ON CONFLICT DO NOTHING;

-- status
INSERT INTO status (id, name) VALUES
(1, 'Pending'),
(2, 'Processing'),
(3, 'Completed'),
(4, 'Cancelled')
ON CONFLICT DO NOTHING;

-- categories
INSERT INTO categories (id, name) VALUES
(1, 'Coffee'),
(2, 'Non-Coffee'),
(3, 'Snack'),
(4, 'Dessert')
ON CONFLICT DO NOTHING;

-- product_size
INSERT INTO product_size (id, name, price) VALUES
(1, 'S', 1.00),
(2, 'M', 1.50),
(3, 'L', 2.00)
ON CONFLICT DO NOTHING;

-- deliveries
INSERT INTO deliveries (id, name, fee) VALUES
(1, 'Dine In', 0),
(2, 'Door Delivery', 10000),
(3, 'Pick Up', 5000)
ON CONFLICT DO NOTHING;

-- payments
-- INSERT INTO payments (code, name, min_amount, max_amount, fee) VALUES
-- ('QRIS', 'QRIS Payment', 1000, 1000000, 0),
-- ('BANK', 'Bank Transfer', 1000, 9999999, 2500)
INSERT INTO payments (id, code, name, min_amount, max_amount, fee) VALUES
(1, 'CARD', 'Card', 10000, 10000000, 1000),
(2, 'BANK', 'Bank account', 10000, 10000000, 2000),
(3, 'COD', 'Cash on delivery', 1000, 10000000, 0)
ON CONFLICT DO NOTHING;

-- products
INSERT INTO products (id, name, price, category_id, img, "desc") VALUES
(1, 'Espresso', 15000, 1, 'https://res.cloudinary.com/dofl9ad81/image/upload/v1751137600/jokopi/product-image-342e8.webp', 'Espresso shot enak di sruput di pagi hari, cepatkan order ya teman-teman'),
(2, 'Latte', 25000, 1, 'https://res.cloudinary.com/dofl9ad81/image/upload/v1751137772/jokopi/product-image-8374e.webp', 'Coffee with milk, enak enak enak rugi kalau nda dicoba, coba dulu ada susunya lho'),
(3, 'Matcha Latte', 30000, 2, 'https://res.cloudinary.com/dofl9ad81/image/upload/v1751137984/jokopi/product-image-2599c.webp', 'Green tea latte, enak enak dicoba dulu matcha nya, pernah dicicipin sama sebastian')
ON CONFLICT DO NOTHING;

-- promo
INSERT INTO promo (id, name, "desc", discount, start_date, end_date, coupon_code, product_id, img) VALUES
(1, 'Espresso Discount', 'Jangan sampai ketinggalan promonya', 40, '2025-06-30', '2027-07-05', 'ESPRESSO', 1, 'https://res.cloudinary.com/dofl9ad81/image/upload/v1751140579/jokopi/promo-image-f0c0a.webp')
ON CONFLICT DO NOTHING;

-- user dummy
-- admin@example.com : admin123
-- user@example.com : hehe1234
INSERT INTO users (id, email, password, phone_number, role_id) VALUES
(1, 'admin@example.com', '$2b$15$C9VZSggBN7wSwrxPxiXWm.FoADdMEdWfkl/MWweGx03HmHILVsFJy', '0123456789', 2),
(2, 'user@example.com', '$2b$15$VKqUNbgkyc3xQ2oAA8viDudvADiN9n7CPprKor9n7uIQAZpq4/3rK', '1234567890', 1)
ON CONFLICT DO NOTHING;

-- user_profile dummy
INSERT INTO user_profile (user_id, display_name, first_name, last_name, gender) VALUES
(1, 'Admin Lord', 'Admin', 'Lord', 1),
(2, 'User Test', 'User', 'Test', 2)
ON CONFLICT DO NOTHING;
