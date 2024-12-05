import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static values = { url: String }

  async connect() {

    const publicKey = document.head.querySelector("meta[name='stripe-pk']").content;
    const stripe = Stripe(publicKey);

    const fetchClientSecret = async () => {
      const response = await post(this.urlValue);
      if (response.ok) {
        const { clientSecret } = await response.json;
        return clientSecret;
      } else {
        throw new Error(`Failed to fetch client secret: ${response.statusText}`);
      }
    };

    const checkout = await stripe.initEmbeddedCheckout({ fetchClientSecret });
    checkout.mount(this.element);
  }
}
