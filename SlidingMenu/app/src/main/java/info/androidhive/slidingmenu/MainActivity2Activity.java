package info.androidhive.slidingmenu;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Fragment;
import android.app.SearchManager;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Point;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Html;
import android.text.method.Touch;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.toolbox.NetworkImageView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import info.androidhive.slidingmenu.app.AppController;
import info.androidhive.slidingmenu.model.NewsObject;

import static android.app.PendingIntent.getActivity;


public class MainActivity2Activity extends Activity {
    private float x1,x2;
    static final int MIN_DISTANCE = 150;
    //left = 0 , right = 1
    static int SLIDE_DIR = 0;
    private   int id=1;
    int type=1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();

        id = Integer.parseInt(intent.getStringExtra("id"));
        type = Integer.parseInt(intent.getStringExtra("type"));


        NewsObject news_to_display= new NewsObject();
        Log.e("Type is ", "" + type);
        switch (type){
            case 1:
                news_to_display = HomeFragment.get_news(id);
                break;
            case 2:
                news_to_display = SearchFragment.get_news(id);
                break;
        }

//        NewsObject newsObjectsList = new NewsObject(t1);
        setContentView(R.layout.activity_main_activity2);

        TextView textView1 = (TextView) findViewById(R.id.headline_detailed_view);
        TextView textView2 = (TextView) findViewById(R.id.contents_detailed_view);
        TextView category = (TextView) findViewById(R.id.category_detailed_view);
        ScrollView scrollView = (ScrollView) findViewById(R.id.scrollview1);

        NetworkImageView imge1 = (NetworkImageView) findViewById(R.id.thumbnail_detailed_view);


       // new DownloadImageTask((ImageView) findViewById(R.id.thumbnail_detailed_view))
         //       .execute(news_to_display.thumbnailUrl);
        imge1.setImageUrl(news_to_display.thumbnailUrl, AppController.getInstance().getImageLoader());

        textView1.setText(news_to_display.headline);
        textView2.setText(Html.fromHtml(news_to_display.summary));
        category.setText(news_to_display.category);


        scrollView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent event) {

                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        x1 = event.getX();
                        break;
                    case MotionEvent.ACTION_UP:
                        x2 = event.getX();
                        float deltaX = x2 - x1;
                        if (Math.abs(deltaX) > MIN_DISTANCE) {
                            // Left to Right swipe action
                            if (x2 > x1) {
                                SLIDE_DIR = 1;
                                Toast.makeText(getApplicationContext(), "Loading next", Toast.LENGTH_SHORT).show();
                                id =id -1;
                                if(id<0){
                                    id= 0;
                                }else
                                    reload();
                            }

                            // Right to left swipe action
                            else {
                                SLIDE_DIR = 0;
                                Toast.makeText(getApplicationContext(), "Loading Previous", Toast.LENGTH_SHORT).show();
                                id =id +1;
                                if(id>=HomeFragment.get_news_numbers()){
                                    id= id-1;
                                }else
                                    reload();
                            }

                        }

                        break;
                }
                return false;
            }
        });




    }

    private void reload() {
        this.finish();

        ScrollView scrollView = (ScrollView) findViewById(R.id.scrollview1);
        //scrollView.setVisibility(View.INVISIBLE);
        Intent intent= new Intent(this, MainActivity2Activity.class);


        intent.putExtra("id", "" + id);
        intent.putExtra("type", "" + type);

        this.startActivity(intent);
        if (SLIDE_DIR==0) {
            overridePendingTransition(R.anim.push_out_left, R.anim.pull_in_right);
        }
        else{
            overridePendingTransition(R.anim.pull_in_left, R.anim.push_out_right);
        }

        if(true) {
            return;
        }


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        // Associate searchable configuration with the SearchView
        SearchManager searchManager =
                (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        SearchView searchView =
                (SearchView) menu.findItem(R.id.action_search).getActionView();
        searchView.setSearchableInfo(
                searchManager.getSearchableInfo(getComponentName()));


        return true;

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
    ImageView bmImage;

    public DownloadImageTask(ImageView bmImage) {
        this.bmImage = bmImage;
    }

    protected Bitmap doInBackground(String... urls) {
        String urldisplay = urls[0];
        Bitmap mIcon11 = null;
        try {
            InputStream in = new java.net.URL(urldisplay).openStream();
            mIcon11 = BitmapFactory.decodeStream(in);
        } catch (Exception e) {
            Log.e("Error", e.getMessage());
            e.printStackTrace();
        }
//        mIcon11.get
        Display display = getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getSize(size);
        int width = size.x;
        int height = size.y;
        Bitmap new1= mIcon11.createScaledBitmap(mIcon11, width, (width / mIcon11.getWidth()) * mIcon11.getHeight(), true);
        return  new1;
    }

    protected void onPostExecute(Bitmap result) {
        bmImage.setImageBitmap(result);
    }

}

}

