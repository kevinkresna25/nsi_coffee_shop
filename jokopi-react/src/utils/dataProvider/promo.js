import api from "./base";

export const createPromoEntry = (
  {
    image = "",
    name = "",
    product_id = "",
    desc = "",
    discount = "",
    coupon_code = "",
    start_date = "",
    end_date = "",
  },
  token,
  controller
) => {
  const bodyForm = new FormData();
  if (image)    bodyForm.append("image", image);
  bodyForm.append("name", name);
  bodyForm.append("desc", desc);
  bodyForm.append("discount", discount);
  bodyForm.append("product_id", product_id);
  // langsung uppercase di sini
  bodyForm.append("coupon_code", coupon_code.toUpperCase());
  // tanggal biasanya sudah string; no need JSON.stringify
  bodyForm.append("start_date", start_date);
  bodyForm.append("end_date", end_date);

  return api.post("/apiv1/promo", bodyForm, {
    signal: controller.signal,
    headers: {
      Authorization: `Bearer ${token}`,
      "Content-Type": "multipart/form-data",
    },
  });
};

export const getPromos = (
  { page = 1, limit = 4, available = "true", searchByName = "" },
  controller
) => {
  const params = {
    page,
    limit,
    available,
    searchByName,
  };
  return api.get("/apiv1/promo", {
    params,
    signal: controller.signal,
  });
};

export const editPromoEntry = (
  promoId,
  {
    image = "",
    name = "",
    product_id = "",
    desc = "",
    discount = "",
    coupon_code = "",
    start_date = "",
    end_date = "",
  },
  token,
  controller
) => {
  const bodyForm = new FormData();
  bodyForm.append("image", image);
  bodyForm.append("name", name);
  bodyForm.append("desc", desc);
  bodyForm.append("discount", discount);
  bodyForm.append("product_id", product_id);
  bodyForm.append("coupon_code", coupon_code);
  bodyForm.append("start_date", JSON.stringify(start_date));
  bodyForm.append("end_date", JSON.stringify(end_date));

  return api.patch(`/apiv1/promo/${promoId}`, bodyForm, {
    signal: controller.signal,
    headers: { Authorization: `Bearer ${token}` },
  });
};

export const getPromoById = (promoId, controller) => {
  return api.get(`/apiv1/promo/${promoId}`, { signal: controller.signal });
};

export const deletePromoEntry = (promoId, token, controller) => {
  return api.delete(`/apiv1/promo/${promoId}`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
    signal: controller.signal,
  });
};
