package dev.linwood.butterfly;

import androidx.test.core.app.ActivityScenario;
import androidx.test.espresso.flutter.EspressoFlutter;
import androidx.test.ext.junit.rules.ActivityScenarioRule;
import androidx.test.ext.junit.runners.AndroidJUnit4;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import dev.linwood.butterfly.MainActivity;
import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy;
import tools.fastlane.screengrab.cleanstatusbar.BluetoothState;
import tools.fastlane.screengrab.cleanstatusbar.CleanStatusBar;
import tools.fastlane.screengrab.cleanstatusbar.MobileDataType;
import tools.fastlane.screengrab.locale.LocaleTestRule;

/** Unit tests for {@link EspressoFlutter}. */
@RunWith(AndroidJUnit4.class)
public class AutomateScreenshotsTest {
    @Before
    public void setUp() throws Exception {
        ActivityScenario.launch(MainActivity.class);
        Thread.sleep(5000);
    }

    @BeforeClass
    public static void beforeAll() {
        Screengrab.setDefaultScreenshotStrategy(new UiAutomatorScreenshotStrategy());

        new CleanStatusBar()
                .setClock("1200")
                .setMobileNetworkDataType(MobileDataType.LTE)
                .setBluetoothState(BluetoothState.DISCONNECTED)
                .enable();

    }

    @Rule
    public ActivityScenarioRule<MainActivity> activityRule = new ActivityScenarioRule<>(MainActivity.class);

    @AfterClass
    public static void afterAll() {
        CleanStatusBar.disable();
    }

    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Test
    public void performMainScreenshot() {
        Screengrab.screenshot("main_view");
    }

}
