# Mystoryova — Customer Account System

## Current State
- Full e-commerce store with cart, checkout, and Razorpay payment integration
- Checkout collects only name, email, phone (no address fields)
- No customer registration or login system
- No saved addresses
- Admin panel handles all backend operations
- Backend: Motoko with books, blog, audiobooks, merchandise, orders, coupons, settings

## Requested Changes (Diff)

### Add
- Customer data types in Motoko: `CustomerAccount` (id, name, email, passwordHash, createdAt), `CustomerAddress` (id, customerId, label, fullName, phone, line1, line2, city, state, pincode, country, isDefault)
- Backend functions: registerCustomer, loginCustomer, getCustomer, updateCustomer, addAddress, getAddresses, updateAddress, deleteAddress, setDefaultAddress, getCustomerOrders
- Frontend: `/account` route — customer login/register/profile/address management/order history/digital downloads placeholder
- Frontend: `useCustomerAuth` hook — manages customer session in localStorage (customerId, token)
- Checkout page: full shipping address form (fullName, phone, line1, line2, city, state, pincode, country), logged-in users can select saved address or add new, guest users fill manually
- Header: account icon linking to `/account` (shows login or profile based on auth state)
- Optional guest checkout flow — clearly visible "Continue as Guest" option
- Order history linked to customer (orders created while logged in are saved to their account)

### Modify
- `Order` type: add `customerId?: Text` and `shippingAddress` fields (fullName, phone, line1, line2, city, state, pincode, country)
- `createOrder` backend function: accept updated Order type with optional customerId and shippingAddress
- Checkout page: replace minimal customer info with full address form + login/guest toggle
- Header: add account icon
- App.tsx: add `/account` route

### Remove
- Nothing removed

## Implementation Plan
1. Add `CustomerAccount`, `CustomerAddress`, `ShippingAddress` types to Motoko backend
2. Add customer CRUD functions: register, login (returns token stored client-side), getCustomer, updateCustomer
3. Add address management: addAddress, getAddresses, updateAddress, deleteAddress, setDefaultAddress
4. Add getCustomerOrders function (filter orders by customerId)
5. Extend Order type with optional customerId and shippingAddress object
6. Create `useCustomerAuth` hook (localStorage-based session: customerId, email, name)
7. Create `/account` page: tabs for Profile, Addresses, Orders, Downloads (placeholder)
8. Update Checkout page: full address form, logged-in user can pick saved address, guest fills manually
9. Update Header: account icon (user icon if logged in, login icon if not)
10. Update App.tsx: add `/account` route
