package geocoding;


import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

/**
 * Custom Geocoding interface. This mirrors the standard google geocoding, but is open
 * code instead of using an sdk.
 * Created by pmacdowell on 2017-02-17.
 */
public interface GeocodingInterface {

    static final String SUFFIX_STRING = "json";

    @GET(SUFFIX_STRING)
    Call<GeocodingPOJO> geocodePostalCode(@Query("key") String api_key,
                                          @Query("address") String zipCode);


}