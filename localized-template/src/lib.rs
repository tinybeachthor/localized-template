pub trait Template {
    type Output;

    fn render(&self, locale: &str) -> Self::Output;
}

impl<T: Template + ?Sized> Template for &T {
    type Output = T::Output;

    #[inline]
    fn render(&self, locale: &str) -> Self::Output {
        T::render(self, locale)
    }
}
