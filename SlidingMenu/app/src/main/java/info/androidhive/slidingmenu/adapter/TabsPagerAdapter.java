package info.androidhive.slidingmenu.adapter;

import android.support.v4.app.FragmentPagerAdapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;

/**
 * Created by shubhambansal on 02/07/15.
 */

public class TabsPagerAdapter extends FragmentPagerAdapter {

    public TabsPagerAdapter(FragmentManager fm) {
        super(fm);
    }

    @Override
    public Fragment getItem(int index) {

        switch (index) {
            case 0:
                // Top Rated fragment activity
                //return new NewsFragment();
            case 1:
                // Games fragment activity
                //return new GamesFragment();
            case 2:
                // Movies fragment activity
                //return new MoviesFragment();
        }

        return null;
    }

    @Override
    public int getCount() {
        // get item count - equal to number of tabs
        return 3;
    }

}